Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319CC68B132
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 19:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBESRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBESRX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 13:17:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46E17CE1;
        Sun,  5 Feb 2023 10:17:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h3so719583wrp.10;
        Sun, 05 Feb 2023 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H5ICTh1rh0epljgxETzZNQyPfYU2WXqF+fw3pjpqXwo=;
        b=J20SEwkEPiND7Km37SXbqwfZJATZ+i6+Ek/aEohW6iFKEs2meAwLbkzh/f47W25dfx
         bPwvhmdq/llmJABkxSblFplencAb4p/i3eAe3UxZhCc79znM6GvOB1nwiN0SPZLxsgj9
         A6Ku9P3Ph91f+zNpd/5fFNHdNtprA3652t/mscQ84UoNbI/ce8+Tr7pUix0xMTQJOnv8
         TkZqM6kAdLzNpUN/FnAGpYM3fS0IZ7UaQaMIwpiytjw19ytPhT/UnlLTTcM7VbhGr5XF
         N/L3Zv0S+b4YPUPYLGOedPJ4FJxtUozfGOudvquB9T3Rx9z4CH5NSR2g0rwJd02Znhbf
         q9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5ICTh1rh0epljgxETzZNQyPfYU2WXqF+fw3pjpqXwo=;
        b=hdMieDVBt3JRYgXDGRBpnbHO4ETBKh0NfqFawIvOf7ALw8/XWcgqytWShSFumolHGT
         mmgi2mxYujTLCtyZCpD16OQjvbpkbHbYn1rSEp4PU0sUtoGTaougQ3m3/z6Ajqcg5m/s
         NAVbKhAZlQdQpwlpTjnKv3WHTqhDhUo3jn9zySr1Cb64lgdrlYMj9YP4HiCm+0btsN2S
         F2ZQ5DCmpt7IVTYmjQTjntt+SLm9a2gG1uBjMoX6wWWrsFQXVaYtU26IXOGpoAtsIpQk
         P97YESK1JaPPqgY/3b/BQzquJM3YCo6A3uarp5FZ6U2mOHmvfw8nF/QmJ/IvFzbBVPkz
         XIOQ==
X-Gm-Message-State: AO0yUKXjcPFoRBmPz2gXNWWl0wPV0pRFNSzfKRXt0Cd9OhGQ8Nxkt2eQ
        Xvo5+PKnDi8Hg1Pjf2EPIqo=
X-Google-Smtp-Source: AK7set8FkShz+h/LJsT3LrluoLPPpvCDCXmDXr0kJiVvJ5tmQwf4Q5+iEu/VM+NEhnY9UGyYQ0qYSg==
X-Received: by 2002:a5d:5982:0:b0:2bf:eec5:3912 with SMTP id n2-20020a5d5982000000b002bfeec53912mr16787933wri.34.1675621039909;
        Sun, 05 Feb 2023 10:17:19 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d690a000000b002bbedd60a9asm7064477wru.77.2023.02.05.10.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:17:19 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 5 Feb 2023 19:17:16 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Y9/yrKZkBK6yzXp+@krava>
References: <20230203162336.608323-1-jolsa@kernel.org>
 <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKBYgN5nWG26s0s-U0=PMAWEc17aGWx76GLUc_PM22ZAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 04, 2023 at 01:21:13AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 3, 2023 at 8:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > I noticed several times in discussions that we should move test kfuncs
> > into kernel module, now perhaps even more pressing with all the kfunc
> > effort. This patchset moves all the test kfuncs into bpf_testmod.
> >
> > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> > bpf_testmod kernel module and BPF programs, which brings some difficulties
> > with __ksym define. But I'm not sure having separate headers for BPF
> > programs and for kernel module would be better.
> >
> > This patchset also needs:
> >   74bc3a5acc82 bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
> > which is only in bpf/master now.
> 
> I thought you've added this patch to CI,
> but cb_refs is still failing on s390...

the CI now fails for s390 with messages like:
   2023-02-04T07:04:32.5185267Z    RES: address of kernel function bpf_kfunc_call_test_fail1 is out of range

so now that we have test kfuncs in the module, the 's32 imm' value of
the bpf call instructions can overflow when the offset between module
and kernel is greater than 2GB ... as explained in the commit that
added the verifier check:

  8cbf062a250e bpf: Reject kfunc calls that overflow insn->imm

not sure we can do anything about that on bpf side.. cc-ing s390 list
and Ilya for ideas/thoughts

maybe we could make bpf_testmod in-tree module and compile it as module
just for some archs

thoughts?

thanks,
jirka
