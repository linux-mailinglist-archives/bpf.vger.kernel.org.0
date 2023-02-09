Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E369026C
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 09:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBIIrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 03:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIIrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 03:47:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5B47436;
        Thu,  9 Feb 2023 00:47:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg26so944075wmb.0;
        Thu, 09 Feb 2023 00:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qn9EbvBNyrGjHsqKyNRcUqE0ZgoknqNHgR4grZIq1og=;
        b=XfFUsep4SvJkXInM+wMQWooY2XG5P56NSZKsbG9bTZjJh/XycVsl5MHTqOG1/Q6kg8
         TCuBMXzctVzdOKE9YfqpPpryW9k0hqdHgnxzzZPKkc0x7l73i6eEYJXeyl4644DWcpBF
         rVVaZTg/dDEidbqgG3V9CxsMM6kH7/LPFIH3M7hhbLTLE+hB7wMJ7CQms0VQzYO67dZx
         eipkf3/WJpokTyumXupM+3VKHdFeDI28ZOMr5Tie7POKePMrARdqqIeOPr2aD8v3Wp5R
         dqHXtz+wnjSEfPsO1mQzCSx6RzhnkWXtFeXAED+Q2+sTf5lMuAqQn02PWegmhJ1pKdmR
         YKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn9EbvBNyrGjHsqKyNRcUqE0ZgoknqNHgR4grZIq1og=;
        b=YxOlY2u6cW9hGknhsr+9fJ/n+zLawTM1OsbUNW5nHSSkkWGT+eylHe0kSoCVHO+SlF
         eSw8s9CqtGodx3tziGL4M+5Qe386b9yJRCPsGvozuzl2c3eECgMG1t2nmJ8UP4u5wBRe
         izvXKelQsv2tlOdug/RZZC+XA2KkM+rIjuza7XRm9L6cpk7KVY2JwBga5OSbNQ4hvuHA
         hV2RDTWR5NDHHsNnsg7R0VWlN3QVvxibpxmvjR16bsl3WmLzouSp4AqYbUc+XMEncmKr
         FM+sYDHas10620Tg/jHANTUNbwksU2aiFzgTreSNLr4NS9y8J6Zz2tAUFR6FoLxt0yZx
         qFUQ==
X-Gm-Message-State: AO0yUKX6aEcPSREnhLdbSPqa9qATqA+l9/5K27j6EHmsawP3a1RBUeDf
        cHxChUAExc+mjO1JfDGAVyo=
X-Google-Smtp-Source: AK7set8tGQUv8NGP+X5kMV2lo4VNAQhkFxeU482r3QGLbDSRvywgf7u7ZkrTRcwOQqUt8oTTY7rbQA==
X-Received: by 2002:a05:600c:996:b0:3df:f85a:4724 with SMTP id w22-20020a05600c099600b003dff85a4724mr9278610wmp.39.1675932449884;
        Thu, 09 Feb 2023 00:47:29 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c35ce00b003dc4ecfc4d7sm1225329wmq.29.2023.02.09.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:47:29 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 09:47:27 +0100
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
Message-ID: <Y+SzH/9usvp7a0DA@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
 <Y9/yrKZkBK6yzXp+@krava>
 <96db3bf7d0a26b161a9846d8fe492c9bd0cb4c49.camel@linux.ibm.com>
 <Y+DFOWZB21MWhYEO@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+DFOWZB21MWhYEO@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 06, 2023 at 10:15:37AM +0100, Jiri Olsa wrote:
> On Sun, Feb 05, 2023 at 07:36:14PM +0100, Ilya Leoshkevich wrote:
> > On Sun, 2023-02-05 at 19:17 +0100, Jiri Olsa wrote:
> > > On Sat, Feb 04, 2023 at 01:21:13AM -0800, Alexei Starovoitov wrote:
> > > > On Fri, Feb 3, 2023 at 8:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > 
> > > > > hi,
> > > > > I noticed several times in discussions that we should move test
> > > > > kfuncs
> > > > > into kernel module, now perhaps even more pressing with all the
> > > > > kfunc
> > > > > effort. This patchset moves all the test kfuncs into bpf_testmod.
> > > > > 
> > > > > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared
> > > > > between
> > > > > bpf_testmod kernel module and BPF programs, which brings some
> > > > > difficulties
> > > > > with __ksym define. But I'm not sure having separate headers for
> > > > > BPF
> > > > > programs and for kernel module would be better.
> > > > > 
> > > > > This patchset also needs:
> > > > >   74bc3a5acc82 bpf: Add missing btf_put to
> > > > > register_btf_id_dtor_kfuncs
> > > > > which is only in bpf/master now.
> > > > 
> > > > I thought you've added this patch to CI,
> > > > but cb_refs is still failing on s390...
> > > 
> > > the CI now fails for s390 with messages like:
> > >    2023-02-04T07:04:32.5185267Z    RES: address of kernel function
> > > bpf_kfunc_call_test_fail1 is out of range
> > > 
> > > so now that we have test kfuncs in the module, the 's32 imm' value of
> > > the bpf call instructions can overflow when the offset between module
> > > and kernel is greater than 2GB ... as explained in the commit that
> > > added the verifier check:
> > > 
> > >   8cbf062a250e bpf: Reject kfunc calls that overflow insn->imm
> > > 
> > > not sure we can do anything about that on bpf side.. cc-ing s390 list
> > > and Ilya for ideas/thoughts
> > > 
> > > maybe we could make bpf_testmod in-tree module and compile it as
> > > module
> > > just for some archs
> > > 
> > > thoughts?
> > 
> > Hi,
> > 
> > I'd rather have this fixed - I guess the problem can affect the users.
> > The ksyms_module test is already denylisted because of that.
> > Unfortunately getting the kernel and the modules close together on
> > s390x is unlikely to happen in the foreseeable future.
> > 
> > What do you think about keeping the BTF ID inside the insn->imm field
> > and putting the 64-bit delta into bpf_insn_aux_data, replacing the
> > call_imm field that we already have there?
> 
> seems tricky wrt other archs.. how about saving address of the kfunc
> in bpf_insn_aux_data and use that in s390 jit code instead of the
> '__bpf_call_base + imm' calculation

any other ideas/thoughts on this?

I don't have s390 server available, so can't really fix/test that..
any chance you work on that?

thanks,
jirka
