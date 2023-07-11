Return-Path: <bpf+bounces-4734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E458974E9A6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07951C2096B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2855017733;
	Tue, 11 Jul 2023 09:01:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0B17723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:01:01 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F1135
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso2592973a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066059; x=1691658059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFhtE6opMoHzSOnpkgd3KnRaLPyT6T6VNhvO8lTEnc=;
        b=ULBGbVB1g+Vz+nkWaqepiSXK7s0k5/l67nT5KdIseLmyGaPaCe+ZE30sbIxmpnuSEe
         F6r2k+L0FLRHKT0aakcBs+NdxFPjn1snEtc7733te1OOMllmWB2Zpt+KcdXaG73nZHUB
         sEJHi7L9wJ9WALLW1krAs8VcFxd9Fv0KKQ2LL8uzeXQea4yUlf+mPugSlxCQGymmjn8t
         si7cQC8y27m7pxyHbk86uyy9JOxJ3COK3pA22eET8pkBONBad8kiAcpJIAy5j90V02gM
         HHf7q3ewwzZAzLtqg1CVtCJnR6IMQspgNhyciswqGy0hjlMeMoMu4PeP1Xai4L8x1XcZ
         vzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066059; x=1691658059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElFhtE6opMoHzSOnpkgd3KnRaLPyT6T6VNhvO8lTEnc=;
        b=OBEtRWyu6gFZ85CX+lLljjBoSR8gDZNSYGvM+4tVTrqT/ufZl1K78dyl1dWyLn4xWL
         c5zyeqDcxfOpz1D9HF5stjZznRjHCexIh1S8fnnVURLuMu04DyzQ1jSu6AcA4j4AJR7B
         BdRUKPq9W7inFegZv8Lbk2LwmxYPOCxPC6y/7jjuqxyDHu89UtP+A3esDynAhnQfVQYE
         WTc8VTuwL2gkcRYt2fLDMVm3U8IjxQPFEgDcQixIyprBCnYoGr1Ax5TIS7WxlxEtx14B
         EvN2+1eUOCFSadntqNhEwyMAdm9BtWhA7Y4o2GyfX5AwliWT022/WRVK6hCDm0jY7JxF
         vRBw==
X-Gm-Message-State: ABy/qLb7K9c+jn8Rfg2k5f7drOntYLrAzOfgltEk1C60WjM+6HZyzhIG
	5vmxctQDdmrY8A5SEZB8iQk=
X-Google-Smtp-Source: APBJJlG3ROT9sT+hw3aibIzRyAQ6iM88kAE09pPZk6Z5rBNOfZMY3Xnbs1rGboV70AcrOKpeDPhd5w==
X-Received: by 2002:aa7:c541:0:b0:51e:166d:8e95 with SMTP id s1-20020aa7c541000000b0051e166d8e95mr13326789edr.4.1689066058528;
        Tue, 11 Jul 2023 02:00:58 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id o4-20020a056402038400b0051dd1c10c13sm947692edv.29.2023.07.11.02.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:00:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:00:54 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 02/26] bpf: Add multi uprobe link
Message-ID: <ZK0aRoV//vsI478R@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-3-jolsa@kernel.org>
 <CAEf4BzY68qYuOYEb7w2S+_m9Gmi0fDnhpwnYcvKzc6QRjLMyxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY68qYuOYEb7w2S+_m9Gmi0fDnhpwnYcvKzc6QRjLMyxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 03:34:10PM -0700, Andrii Nakryiko wrote:

SNIP

> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 60a9d59beeab..a236139f08ce 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1036,6 +1036,7 @@ enum bpf_attach_type {
> >         BPF_LSM_CGROUP,
> >         BPF_STRUCT_OPS,
> >         BPF_NETFILTER,
> > +       BPF_TRACE_UPROBE_MULTI,
> >         __MAX_BPF_ATTACH_TYPE
> >  };
> >
> > @@ -1053,6 +1054,7 @@ enum bpf_link_type {
> >         BPF_LINK_TYPE_KPROBE_MULTI = 8,
> >         BPF_LINK_TYPE_STRUCT_OPS = 9,
> >         BPF_LINK_TYPE_NETFILTER = 10,
> > +       BPF_LINK_TYPE_UPROBE_MULTI = 11,
> >
> >         MAX_BPF_LINK_TYPE,
> >  };
> > @@ -1170,6 +1172,11 @@ enum bpf_link_type {
> >   */
> >  #define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
> >
> > +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> > + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> > + */
> > +#define BPF_F_UPROBE_MULTI_RETURN      (1U << 0)
> > +
> 
> any reason why we don't use anonymous ENUMs for all these UAPI
> constants? When we need to use these flags from BPF side (e.g., for
> BPF LSM), having them as #defines will be a PITA, as they won't be
> present in vmlinux.h

ugh right, we already did that before.. will change

> 
> 
> >  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >   * the following extensions:
> >   *
> > @@ -1579,6 +1586,13 @@ union bpf_attr {
> >                                 __s32           priority;
> >                                 __u32           flags;
> >                         } netfilter;
> > +                       struct {
> > +                               __u32           flags;
> > +                               __u32           cnt;
> 
> total nit, but I'd move it after path/offsets/ref_ctr_offsets, and
> make the order cnt (as it applies to previous two
> offsets/ref_ctr_offsets) and then flags last. Seems like more logical
> order, but totally subjective

ok

> 
> > +                               __aligned_u64   path;
> > +                               __aligned_u64   offsets;
> > +                               __aligned_u64   ref_ctr_offsets;
> > +                       } uprobe_multi;
> >                 };
> >         } link_create;
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 9046ad0f9b4e..3b0582a64ce4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2813,10 +2813,12 @@ static void bpf_link_free_id(int id)
> >
> >  /* Clean up bpf_link and corresponding anon_inode file and FD. After
> >   * anon_inode is created, bpf_link can't be just kfree()'d due to deferred
> > - * anon_inode's release() call. This helper marksbpf_link as
> > + * anon_inode's release() call. This helper marks bpf_link as
> >   * defunct, releases anon_inode file and puts reserved FD. bpf_prog's refcnt
> >   * is not decremented, it's the responsibility of a calling code that failed
> >   * to complete bpf_link initialization.
> > + * This helper eventually calls link's dealloc callback, but does not call
> > + * link's release callback.
> 
> Thanks for clarifying comments!
> 
> >   */
> >  void bpf_link_cleanup(struct bpf_link_primer *primer)
> >  {
> > @@ -3589,8 +3591,12 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
> >                 if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
> >                     attach_type != BPF_TRACE_KPROBE_MULTI)
> >                         return -EINVAL;
> > +               if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
> > +                   attach_type != BPF_TRACE_UPROBE_MULTI)
> > +                       return -EINVAL;
> >                 if (attach_type != BPF_PERF_EVENT &&
> > -                   attach_type != BPF_TRACE_KPROBE_MULTI)
> > +                   attach_type != BPF_TRACE_KPROBE_MULTI &&
> > +                   attach_type != BPF_TRACE_UPROBE_MULTI)
> 
> if this keeps growing, we should think about having a switch in a
> switch to not repeat BPF_TRACE_UPROBE_MULTI and BPF_TRACE_KPROBE_MULTI
> twice

ok

SNIP

> > +       for (i = 0; i < cnt; i++) {
> > +               err = uprobe_register_refctr(d_real_inode(link->path.dentry),
> > +                                            uprobes[i].offset,
> > +                                            ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
> > +                                            &uprobes[i].consumer);
> > +               if (err) {
> > +                       bpf_uprobe_unregister(&path, uprobes, i);
> > +                       bpf_link_cleanup(&link_primer);
> > +                       kvfree(ref_ctr_offsets);
> 
> are we missing path_put() in this error handling path? so maybe goto
> error_path_put here instead of return?

aaaah right path_put needs to go to dealloc callback :-\ will change, thanks

jirka

