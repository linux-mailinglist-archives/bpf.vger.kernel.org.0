Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D5636EA6
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKXACQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXACN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:02:13 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1F8FB3C
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:02:12 -0800 (PST)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzgw-000NtC-8t; Thu, 24 Nov 2022 01:02:10 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oxzgv-000Cxu-TP; Thu, 24 Nov 2022 01:02:09 +0100
Subject: Re: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced
 in func_proto arg
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
References: <20221123035422.872531-1-sdf@google.com>
 <20221123035422.872531-2-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <384163f2-0f33-6db5-3b48-92b47f8fb5e6@iogearbox.net>
Date:   Thu, 24 Nov 2022 01:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221123035422.872531-2-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26729/Wed Nov 23 09:18:01 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/22 4:54 AM, Stanislav Fomichev wrote:
> Syzkaller managed to hit anoher decl_tag issue:
> 
>   btf_func_proto_check kernel/bpf/btf.c:4506 [inline]
>   btf_check_all_types kernel/bpf/btf.c:4734 [inline]
>   btf_parse_type_sec+0x1175/0x1980 kernel/bpf/btf.c:4763
>   btf_parse kernel/bpf/btf.c:5042 [inline]
>   btf_new_fd+0x65a/0xb00 kernel/bpf/btf.c:6709
>   bpf_btf_load+0x6f/0x90 kernel/bpf/syscall.c:4342
>   __sys_bpf+0x50a/0x6c0 kernel/bpf/syscall.c:5034
>   __do_sys_bpf kernel/bpf/syscall.c:5093 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5091 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5091
>   do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> 
> This seems similar to commit ea68376c8bed ("bpf: prevent decl_tag from
> being referenced in func_proto") but for the argument.
> 
> Reported-by: syzbot+8dd0551dda6020944c5d@syzkaller.appspotmail.com
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   kernel/bpf/btf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1a59cc7ad730..cb43cb842e16 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4792,6 +4792,11 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
>   			break;
>   		}
>   
> +		if (btf_type_is_resolve_source_only(arg_type)) {
> +			btf_verifier_log_type(env, t, "Invalid arg#%u", i + 1);
> +			return -EINVAL;
> +		}
> +

Applied, could you do a small follow-up cleanup: most of the error cases in the loop in
btf_func_proto_check() bail out with err = -EINVAL + break and the above now deviates
from that, but rightfully so given there's no good reason as we just return err anyway.
Would be good to make this consistent with return -EINVAL / return err also for the other
cases.

>   		if (args[i].name_off &&
>   		    (!btf_name_offset_valid(btf, args[i].name_off) ||
>   		     !btf_name_valid_identifier(btf, args[i].name_off))) {
> 

Thanks,
Daniel
