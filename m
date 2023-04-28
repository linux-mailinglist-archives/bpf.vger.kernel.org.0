Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065766F109C
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjD1C66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjD1C65 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:58:57 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [IPv6:2001:41d0:203:375::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949A32706
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:58:55 -0700 (PDT)
Message-ID: <6d388abe-4a08-7d71-ad43-237562841949@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682650731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhTMpiNbMpOVXR4GSougtaRpsF2DM3Y7IaqfwsXAC2o=;
        b=JCEZVoqC6ECVrODdT3njGbURw5Bu6XhZIzeGON8uLE9mSK9KPw4+3H0h649TAnTjhPp/JX
        dVNt0OgkTD0FDvPuyOv6kQnO/b37dpC3wHs+WDN4M7cWK3cVerMqAOcePvjW9vKw4TM16Y
        0OHSYDHmJnVe/2TWT/d26nZhrK0pkfM=
Date:   Thu, 27 Apr 2023 19:58:48 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] libbpf: btf_dump_type_data_check_overflow
 needs to consider BTF_MEMBER_BITFIELD_SIZE
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230428013638.1581263-1-martin.lau@linux.dev>
In-Reply-To: <20230428013638.1581263-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/23 6:36 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The btf_dump/struct_data selftest is failing with:
> test_btf_dump_struct_data:FAIL:unexpected return value dumping fs_context unexpected unexpected return value dumping fs_context: actual -7 != expected 264
> 
> The reason is in btf_dump_type_data_check_overflow(). It does not use
> BTF_MEMBER_BITFIELD_SIZE from the struct's member (btf_member). Instead,
> it is using the enum size which is 4. It had been working till the recent
> commit 4e04143c869c ("fs_context: drop the unused lsm_flags member")
> removed an integer member which also removed the 4 bytes padding at the end
> of the fs_context. Missing this 4 bytes padding exposed this bug.
> In particular, when btf_dump_type_data_check_overflow() reaches
> the member 'phase', -E2BIG is returned.
> 
> The fix is to pass bit_sz to btf_dump_type_data_check_overflow().
> In btf_dump_type_data_check_overflow(), it does a different size
> check when bit_sz is not zero.
> 
> The current fs_context:
> 
> [3600] ENUM 'fs_context_purpose' encoding=UNSIGNED size=4 vlen=3
> 	'FS_CONTEXT_FOR_MOUNT' val=0
> 	'FS_CONTEXT_FOR_SUBMOUNT' val=1
> 	'FS_CONTEXT_FOR_RECONFIGURE' val=2
> [3601] ENUM 'fs_context_phase' encoding=UNSIGNED size=4 vlen=7
> 	'FS_CONTEXT_CREATE_PARAMS' val=0
> 	'FS_CONTEXT_CREATING' val=1
> 	'FS_CONTEXT_AWAITING_MOUNT' val=2
> 	'FS_CONTEXT_AWAITING_RECONF' val=3
> 	'FS_CONTEXT_RECONF_PARAMS' val=4
> 	'FS_CONTEXT_RECONFIGURING' val=5
> 	'FS_CONTEXT_FAILED' val=6
> [3602] STRUCT 'fs_context' size=264 vlen=21
> 	'ops' type_id=3603 bits_offset=0
> 	'uapi_mutex' type_id=235 bits_offset=64
> 	'fs_type' type_id=872 bits_offset=1216
> 	'fs_private' type_id=21 bits_offset=1280
> 	'sget_key' type_id=21 bits_offset=1344
> 	'root' type_id=781 bits_offset=1408
> 	'user_ns' type_id=251 bits_offset=1472
> 	'net_ns' type_id=984 bits_offset=1536
> 	'cred' type_id=1785 bits_offset=1600
> 	'log' type_id=3621 bits_offset=1664
> 	'source' type_id=42 bits_offset=1792
> 	'security' type_id=21 bits_offset=1856
> 	's_fs_info' type_id=21 bits_offset=1920
> 	'sb_flags' type_id=20 bits_offset=1984
> 	'sb_flags_mask' type_id=20 bits_offset=2016
> 	's_iflags' type_id=20 bits_offset=2048
> 	'purpose' type_id=3600 bits_offset=2080 bitfield_size=8
> 	'phase' type_id=3601 bits_offset=2088 bitfield_size=8
> 	'need_free' type_id=67 bits_offset=2096 bitfield_size=1
> 	'global' type_id=67 bits_offset=2097 bitfield_size=1
> 	'oldapi' type_id=67 bits_offset=2098 bitfield_size=1
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Missed the fixes tag.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
