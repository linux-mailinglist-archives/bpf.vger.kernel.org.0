Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C620683AD0
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 00:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAaX7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 18:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjAaX7M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 18:59:12 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E7683FD
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 15:59:02 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id m12so3827938qth.4
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 15:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyycsR+GyWZO8MKVTswhN7n1BBuR/VQutv9BZW4+W6w=;
        b=12uklE4Zb2xseuLQ7UMlJNQuzsdujO/UPMH/ungCk83bzzKqF5TSK5vnVGNGYeH5QJ
         sG9KtWJNnNkUmd1Mw5bQpSzq2aZCgLNqtPo4fvwonvsvJahSFyIzfYkIxLTLDO4cSYSD
         DI0K4SubZN1dcrrLhCjLPYV/N4m2M9JkgYDfBX0qeFA+Fu1N//+X4nojjYqe69HngXo5
         M6OcqEcVyHWU4siQ/IgmaRyd1ITQ58M+LPMnjlsT1TWFxvcIvfBq+VV2az8cz4X2Ywbl
         rG+JWc+OGATw1JLF+Q0yzcuHF0U7C+9rqtuJ8QkI4ae34yKtnAtRJYTtOfMS2K/jUUD1
         1P9w==
X-Gm-Message-State: AO0yUKUYs/jKz0POqwk7uG0SZc9d2CPNf9xgBGJj/+fGzWKG3uTFEHnV
        WR5FVJdXyW3BMyn4AVWK6mc=
X-Google-Smtp-Source: AK7set80v5c9Ve/BEQllCUzXq8QjACj9V3HWYTYNUZpWaIVRtuTOk403eGjVYjpJqSkbpJzibFfxKA==
X-Received: by 2002:a05:622a:451:b0:3b8:3c4e:d334 with SMTP id o17-20020a05622a045100b003b83c4ed334mr990894qtx.50.1675209541222;
        Tue, 31 Jan 2023 15:59:01 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:62fc])
        by smtp.gmail.com with ESMTPSA id x4-20020ac87ec4000000b003b642c7c772sm10651742qtj.71.2023.01.31.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:59:00 -0800 (PST)
Date:   Tue, 31 Jan 2023 17:58:58 -0600
From:   David Vernet <void@manifault.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9mrQkfRFfCNuf+v@maniforge>
References: <Y9gOGZ20aSgsYtPP@kernel.org>
 <Y9gkS6dcXO4HWovW@kernel.org>
 <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org>
 <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
> On 31/01/2023 18:16, Alexei Starovoitov wrote:
> > On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>
> >>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
> >>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
> >>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
> >>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>>>>> +++ b/dwarves.h
> >>>>>>>> @@ -262,6 +262,7 @@ struct cu {
> >>>>>>>>   uint8_t          has_addr_info:1;
> >>>>>>>>   uint8_t          uses_global_strings:1;
> >>>>>>>>   uint8_t          little_endian:1;
> >>>>>>>> + uint8_t          nr_register_params;
> >>>>>>>>   uint16_t         language;
> >>>>>>>>   unsigned long    nr_inline_expansions;
> >>>>>>>>   size_t           size_inline_expansions;
> >>>>>>>
> >>>>>
> >>>>>> Thanks for this, never thought of cross-builds to be honest!
> >>>>>
> >>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
> >>>>>> into one small thing on one system; turns out EM_RISCV isn't
> >>>>>> defined if using a very old elf.h; below works around this
> >>>>>> (dwarves otherwise builds fine on this system).
> >>>>>
> >>>>> Ok, will add it and will test with containers for older distros too.
> >>>>
> >>>> Its on the 'next' branch, so that it gets tested in the libbpf github
> >>>> repo at:
> >>>>
> >>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
> >>>>
> >>>> It failed yesterday and today due to problems with the installation of
> >>>> llvm, probably tomorrow it'll be back working as I saw some
> >>>> notifications floating by.
> >>>>
> >>>> I added the conditional EM_RISCV definition as well as removed the dup
> >>>> iterator that Jiri noticed.
> >>>>
> >>>
> >>> Thanks again Arnaldo! I've hit an issue with this series in
> >>> BTF encoding of kfuncs; specifically we see some kfuncs missing
> >>> from the BTF representation, and as a result:
> >>>
> >>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> >>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> >>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> >>>
> >>> Not sure why I didn't notice this previously.
> >>>
> >>> The problem is the DWARF - and therefore BTF - generated for a function like
> >>>
> >>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> >>> {
> >>>         return -EOPNOTSUPP;
> >>> }
> >>>
> >>> looks like this:
> >>>
> >>>    <8af83a2>   DW_AT_external    : 1
> >>>     <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
> >>>     <8af83a6>   DW_AT_decl_file   : 5
> >>>     <8af83a7>   DW_AT_decl_line   : 737
> >>>     <8af83a9>   DW_AT_decl_column : 5
> >>>     <8af83aa>   DW_AT_prototyped  : 1
> >>>     <8af83aa>   DW_AT_type        : <0x8ad8547>
> >>>     <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> >>>  <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
> >>>     <8af83b3>   DW_AT_name        : ctx
> >>>     <8af83b7>   DW_AT_decl_file   : 5
> >>>     <8af83b8>   DW_AT_decl_line   : 737
> >>>     <8af83ba>   DW_AT_decl_column : 51
> >>>     <8af83bb>   DW_AT_type        : <0x8af421d>
> >>>  <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
> >>>     <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
> >>>     <8af83c4>   DW_AT_decl_file   : 5
> >>>     <8af83c5>   DW_AT_decl_line   : 737
> >>>     <8af83c7>   DW_AT_decl_column : 61
> >>>     <8af83c8>   DW_AT_type        : <0x8adc424>
> >>>
> >>> ...and because there are no further abstract origin references
> >>> with location information either, we classify it as lacking
> >>> locations for (some of) the parameters, and as a result
> >>> we skip BTF encoding. We can work around that by doing this:
> >>>
> >>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
> >>
> >> replied in the other thread. This attr is broken and discouraged by gcc.
> >>
> >> For kfuncs where aregs are unused, please try __used and __may_unused
> >> applied to arguments.
> >> If that won't work, please add barrier_var(arg) to the body of kfunc
> >> the way we do in selftests.
> > 
> > There is also
> > # define __visible __attribute__((__externally_visible__))
> > that probably fits the best here.
> > 
> 
> testing thus for seems to show that for x86_64, David's series
> (using __used noinline in the BPF_KFUNC() wrapper and extended
> to cover recently-arrived kfuncs like cpumask) is sufficient
> to avoid resolve_btfids warnings.

Nice. Alexei -- lmk how you want to proceed. I think using the
__bpf_kfunc macro in the short term (with __used and noinline) is
probably the least controversial way to unblock this, but am open to
other suggestions.

> 
> We need to update the LSM_HOOK() definition for BPF LSM too,
> otherwise they will cause problems with missing btfids also.
> 
> With all that done, I'm not seeing resolve_btfids complaints
> for x86_64 (tested gcc9,11). I also tried using __visible, but
> using that in the kfunc wrapper causes problems for the static tcp 
> congestion control functions. We see warnings like these if __visible
> is used in BPF_KFUNC():
> 
> net/ipv4/tcp_dctcp.c:79:1: warning: ‘externally_visible’ attribute have effect only on public objects [-Wattributes]
>    79 | {

Yeah, I tend to think we should try to avoid using hidden / visible
attributes given that (to my knowledge) they're really more meant for
controlling whether a symbol is exported from a shared object rather
than controlling what the compiler is doing when it creates the
compilation unit. One could imagine that in an LTO build, the compiler
would still optimize the function regardless of its visibility for that
reason, though it's possible I don't have the full picture.

> 
> However, for aarch64 with the same changes we see a bunch of complaints
> from resolve_btfids for BPF_KFUNC()-wrapped kfuncs and LSM hooks:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol tcp_cong_avoid_ai
> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
> WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_state_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_xfrm_policy_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_tun_dev_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_to_inode
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_task_free
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sock_graft
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_getsecid
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sk_clone_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_shm_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sem_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sctp_sk_clone
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_free_mnt_opts
> WARN: resolve_btfids: unresolved symbol bpf_lsm_sb_delete
> WARN: resolve_btfids: unresolved symbol bpf_lsm_req_classify_flow
> WARN: resolve_btfids: unresolved symbol bpf_lsm_release_secctx
> WARN: resolve_btfids: unresolved symbol bpf_lsm_perf_event_free
> WARN: resolve_btfids: unresolved symbol bpf_lsm_msg_queue_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_msg_msg_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_key_free
> WARN: resolve_btfids: unresolved symbol bpf_lsm_ipc_getsecid
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_post_setxattr
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_invalidate_secctx
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_getsecid
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inode_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_csk_clone
> WARN: resolve_btfids: unresolved symbol bpf_lsm_inet_conn_established
> WARN: resolve_btfids: unresolved symbol bpf_lsm_ib_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_file_set_fowner
> WARN: resolve_btfids: unresolved symbol bpf_lsm_file_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_d_instantiate
> WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_transfer
> WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_getsecid
> WARN: resolve_btfids: unresolved symbol bpf_lsm_cred_free
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bprm_committing_creds
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bprm_committed_creds
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bpf_prog_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_bpf_map_free_security
> WARN: resolve_btfids: unresolved symbol bpf_lsm_audit_rule_free
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass_ctx
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_pass1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail3
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test3
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb_release
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb1_release
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_int_mem_release
> WARN: resolve_btfids: unresolved symbol bpf_cpumask_any
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
> WARN: resolve_btfids: unresolved symbol bpf_cast_to_kern_ctx
>   NM      System.map

Is that all of them? That's surprising that we'd only fail to resolve a
random subset of the kfuncs, e.g. bpf_cpumask_any(). There's nothing
whatsoever special about it.

> 
> Thanks!
> 
> Alan
