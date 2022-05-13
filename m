Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CD52673A
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382028AbiEMQj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381108AbiEMQjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 12:39:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9147B10A1
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 09:39:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c14so8154037pfn.2
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJ3Tvbmb/6aYa8WeRFqzLb9av4hdEL42LhfRg/IQKu4=;
        b=XbCrxgJ1ncUUThfDh//76lkR0DGBs2YB96VprJvWKf81XT3wIJ0X5+kk2C1Zd1HzPH
         Xq8W7dZ9H5oW+x6gFcTHE6deD6EZ+7doy4r+hrM4ip6yIBOMBeIFfMhIH4Rv5tNB+e1R
         58P6QeANww5otjDU5M6Zm7J9IWy/oNQifwjeSdWgss3E85NSS2bvIL1fMRY2yr19muTK
         0iNZJLbL5vMWPV4qbG5/6u6MZEkBL3WoP2E8R1L+VBV8TcLHT3qQM14F6mdSRoVt0g8W
         ZT773qcQLPv5Ht/tJ55hx41p5ILZ09N7Z+mKZSA9IgENQ/Gkpdy/l8beNkBLiRacaj1O
         qyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJ3Tvbmb/6aYa8WeRFqzLb9av4hdEL42LhfRg/IQKu4=;
        b=YySCyBcESdLU2KI1wEmdNWHGOTAC3SQPid64Uumc7l6HEm7gw7CZ6cZUeDqwlO3NgG
         ClHEvcg2FNArVfsjEcB4TQRRLGbIudeK+ghW0Wz5OCJEvuaMfTn8fM5dP+R2KxxMzi4q
         nXvS95g17pSphfAhjLEA2zQtnDA44Yc5pQ3///WoHGzp/dE6Uzb7Pg/l3AwQ2stEvu0n
         Vo7YNytZ7zGbcdm0ceR0tK3wwnZG63/Uy66lAEYfBHCIsLh2WZ67ZvNzPVkOMuIyVZs0
         cMon55wlMmQHzIhLbj5TxBqwzv8LtN61P5uZfXhAMWSMaeRmeSFxt0fuvxEu9PhHj0IP
         KN8Q==
X-Gm-Message-State: AOAM532gDy+wBb5Lp9iCeWS9PPeyYOLM5rB3BzG1PK0qBvlujEkkFxQl
        TpASQxzjJ5iB7s710DZR+dvPJlbTS3Q=
X-Google-Smtp-Source: ABdhPJzfCBxmafKK0QpJ/FmiJnpp+tnj8DlG3E0Sjo1Yg/UDFbe6SGkNcJIictPErOjNCWbmFDV84A==
X-Received: by 2002:a05:6a00:4197:b0:510:671d:709c with SMTP id ca23-20020a056a00419700b00510671d709cmr5528001pfb.61.1652459994001;
        Fri, 13 May 2022 09:39:54 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::4:7ccc])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0015e8d4eb200sm2114340pln.74.2022.05.13.09.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 09:39:53 -0700 (PDT)
Date:   Fri, 13 May 2022 09:39:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs
 and implement malloc dynptrs
Message-ID: <20220513163951.tg2nrsuwlglpxvu7@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com>
 <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
 <CAJnrk1Zs6dVAqwbCQ1VShH+00D_EY7ePjyyhfj5UVO5zwSO7JA@mail.gmail.com>
 <b35e19c7-82ea-27fa-4fd6-50e36e64241c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35e19c7-82ea-27fa-4fd6-50e36e64241c@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 03:12:06PM +0200, Daniel Borkmann wrote:
> 
> Thinking more about it, is there even any value for BPF_FUNC_dynptr_* for
> fully unpriv BPF if these are rejected anyway by the spectre mitigations
> from verifier?
...
> So either for alloc, we always built-in __GFP_ZERO or bpf_dynptr_alloc()
> helper usage should go under perfmon_capable() where it's allowed to read
> kernel mem.

dynptr should probably by cap_bpf and cap_perfmon for now.
Otherwise we will start adding cap_perfmon checks in run-time to helpers
which is not easy to do. Some sort of prog or user context would need
to be passed as hidden arg into helper. That's too much hassle just
to enable dynptr for cap_bpf only.

Similar problem with gfp_account... remembering memcg and passing all
the way to bpf_dynptr_alloc helper is not easy. And it's not clear
which memcg to use. The one where task was that loaded that bpf prog?
That task could have been gone and cgroup is in dying stage.
bpf prog is executing some context and allocating memory for itself.
Like kernel allocates memory for its needs. It doesn't feel right to
charge prog's memcg in that case. It probably should be an explicit choice
by bpf program author. Maybe in the future we can introduce a fake map
for such accounting needs and bpf prog could pass a map pointer to
bpf_dynptr_alloc. When such fake and empty map is created the memcg
would be recorded the same way we do for existing normal maps.
Then the helper will look like:
bpf_dynptr_alloc(struct bpf_map *map, u32 size, u64 flags, struct bpf_dynptr *ptr)
{
  set_active_memcg(map->memcg);
  kmalloc into dynptr;
}

Should we do this change now and allow NULL to be passed as a map ?
This way the bpf prog will have a choice whether to account into memcg or not.
Maybe it's all overkill and none of this needed?

On the other side maybe map should be a mandatory argument and dynptr_alloc
can do its own memory accounting for stats ? atomic inc and dec is probably
an acceptable overhead? bpftool will print the dynptr allocation stats.
All sounds nice and extra visibility is great, but the kernel code that
allocates for the kernel doesn't use memcg. bpf progs semantically are part of
the kernel whereas memcg is a mechanism to restrict memory that kernel
allocated on behalf of user tasks. We abused memcg for bpf progs/maps
to have a limit. Not clear whether we should continue doing so for dynpr_alloc
and in the future for kptr_alloc. gfp_account adds overhead too. It's not free.
Thoughts?
