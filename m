Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54B68B868
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 10:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBFJPo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 04:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBFJPn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 04:15:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04B3212D;
        Mon,  6 Feb 2023 01:15:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg26so8163773wmb.0;
        Mon, 06 Feb 2023 01:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mZ0xWkPNZ4hmW2vvs+f5UVSQ+AnfRdSc/rJdUnUEKCk=;
        b=EZiP+qfZZ2vFI66D6cFJ4tRzgZmIsbEzmmRR2YHlhTThxz1noQFtlNiNWoeeFnYET8
         s1a6r/cX5NaptNTBg3fmI0khxp1XoZJk/xkHc3NiJN35fLQxPqnCG2oi8f8svPXdI1qQ
         uqXBoD5aRETcnD0iJNwlYu//S9H6VsbNt6ve4Eexrm02kKLo4ENgTMFzyGRodYkOAXrY
         oEbeY/MjyBxsIVt7ygqfY+mv/hbikLl8WiY69rz58+N4+mhqS7uolIJO3YFwJMhNjMd4
         EYVoqF5evnOhMdhff5WorqXR84A3q2x1La7KdCNdJ34zPA98NjPRxTfy4rQJCQXCOixj
         SV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ0xWkPNZ4hmW2vvs+f5UVSQ+AnfRdSc/rJdUnUEKCk=;
        b=QK0Qw5r8u/rImv3/bV7GbJ2RLl8n/bfJUw1TxcGe082Rj1Gd7VWBNPZmqug93sn6Sp
         DNMKXuCezXje4SZYdplCxq7Oi+WiPx76ekvAdk793FHMh9lO1FCa9GNH2jnRa2GPw/Ib
         61Z9XrdTT5QEDtVpJxs8ibRkB5G/OIlDqQ1guBJUorOU5uHAK9CYZEtBpR7DyQqn+qly
         njTzTE0t4bTN1zcWchwgzXRRopOVjguuV5YVfWyXDR8DnhobghO9YSK95OPKVe17Igo8
         I+kTHNQAUH1rWu/gDTfXobGMTYZmdwV7XfvONj8K8ss5QrPJXArV6zEq3NGVjAw8raiv
         Pi/Q==
X-Gm-Message-State: AO0yUKWe+I7lonqpfg27lZsIH21aTxTynknjKbZf4bfED2gVVqQkvHBs
        2wa2Z9406zKPlW+URbWYoVE=
X-Google-Smtp-Source: AK7set9HplAw3gx0hCsrG6659a/FiLOrjP9EhP3KSmy3vi2Ls4ONVAdSWetY0B04BjyyvJJc7wfzEQ==
X-Received: by 2002:a05:600c:b88:b0:3df:9858:c033 with SMTP id fl8-20020a05600c0b8800b003df9858c033mr10522279wmb.8.1675674940417;
        Mon, 06 Feb 2023 01:15:40 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm10789353wmo.21.2023.02.06.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:15:39 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 6 Feb 2023 10:15:37 +0100
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Artem Savkov <asavkov@redhat.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCHv3 bpf-next 0/9] bpf: Move kernel test kfuncs into
 bpf_testmod
Message-ID: <Y+DFOWZB21MWhYEO@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
 <Y9/yrKZkBK6yzXp+@krava>
 <96db3bf7d0a26b161a9846d8fe492c9bd0cb4c49.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96db3bf7d0a26b161a9846d8fe492c9bd0cb4c49.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 05, 2023 at 07:36:14PM +0100, Ilya Leoshkevich wrote:
> On Sun, 2023-02-05 at 19:17 +0100, Jiri Olsa wrote:
> > On Sat, Feb 04, 2023 at 01:21:13AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Feb 3, 2023 at 8:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > 
> > > > hi,
> > > > I noticed several times in discussions that we should move test
> > > > kfuncs
> > > > into kernel module, now perhaps even more pressing with all the
> > > > kfunc
> > > > effort. This patchset moves all the test kfuncs into bpf_testmod.
> > > > 
> > > > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared
> > > > between
> > > > bpf_testmod kernel module and BPF programs, which brings some
> > > > difficulties
> > > > with __ksym define. But I'm not sure having separate headers for
> > > > BPF
> > > > programs and for kernel module would be better.
> > > > 
> > > > This patchset also needs:
> > > >   74bc3a5acc82 bpf: Add missing btf_put to
> > > > register_btf_id_dtor_kfuncs
> > > > which is only in bpf/master now.
> > > 
> > > I thought you've added this patch to CI,
> > > but cb_refs is still failing on s390...
> > 
> > the CI now fails for s390 with messages like:
> >    2023-02-04T07:04:32.5185267Z    RES: address of kernel function
> > bpf_kfunc_call_test_fail1 is out of range
> > 
> > so now that we have test kfuncs in the module, the 's32 imm' value of
> > the bpf call instructions can overflow when the offset between module
> > and kernel is greater than 2GB ... as explained in the commit that
> > added the verifier check:
> > 
> >   8cbf062a250e bpf: Reject kfunc calls that overflow insn->imm
> > 
> > not sure we can do anything about that on bpf side.. cc-ing s390 list
> > and Ilya for ideas/thoughts
> > 
> > maybe we could make bpf_testmod in-tree module and compile it as
> > module
> > just for some archs
> > 
> > thoughts?
> 
> Hi,
> 
> I'd rather have this fixed - I guess the problem can affect the users.
> The ksyms_module test is already denylisted because of that.
> Unfortunately getting the kernel and the modules close together on
> s390x is unlikely to happen in the foreseeable future.
> 
> What do you think about keeping the BTF ID inside the insn->imm field
> and putting the 64-bit delta into bpf_insn_aux_data, replacing the
> call_imm field that we already have there?

seems tricky wrt other archs.. how about saving address of the kfunc
in bpf_insn_aux_data and use that in s390 jit code instead of the
'__bpf_call_base + imm' calculation

jirka
