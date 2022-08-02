Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801FA587E8F
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 17:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiHBPFq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiHBPFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 11:05:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0810FE9
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 08:05:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so10514513edd.4
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRGzxYLFoGjpg1zgxllnXNs0e4zRM3heGoez7OwXxFo=;
        b=EZ95xoj+fheOvnHUqDPXFTGwwH9oZQqGk9cvWskzlfria9CL4pFmiZJiJN0PhsE3hg
         uFjz40pCnzRvusraD03AqFBBW2t638rBQnZ09y3hIdy6NAVtQXV/ZqYHW9cJuQfuCOdh
         WmwF7G06vxCxsyN7z1gA6ukBVMiyDHhYIU9ZYwckZHN9buVsMV0ILHS3sWu+fb0rdCoB
         nZYfZuwfQ9vbrBb8J7fwASsHJn4tbJ0kxWBDRSUrOsd/lOPNkffc0+Wk0c14Z7p50eQW
         UhrC5mlhxksACZgqSHmYlesh9emoizQsKo7Udo1/Tz7p2CbI4/tfTrnmdAtcTm/Kzrqw
         Hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRGzxYLFoGjpg1zgxllnXNs0e4zRM3heGoez7OwXxFo=;
        b=sDPDzblSiy45iBzdJUGqG3TgQ3Zw8fg5AZm4wZhD07iZOBxHTZryfFDxlZIhEAk2ar
         uxUaFEIn24amIuEQZYpv4kllY4chfZY1EKKeFRe8MZHqfl6vw/julwjAS8hg2rA4gpn2
         Ccgy13cKin9y6wj6+NgoRkue1Gi4nYhadqZzZo/X2w4KXGM8iVMSzcPeztBHbmQduOVu
         mShHNoPpMtqwmi19b0eZNhTarsFoEUMe1gaUaSvMr6PR/j8CZbbRNFa4hVU4UgfSjntQ
         h44pfHoenimwMrk1gCfkQRGaZ9RCOGex5LKdcyrEFKSDgwaXmljb0yQ1L4vXQXKl+Dhr
         /LdQ==
X-Gm-Message-State: AJIora/j/yfC3QEO5imfEn0p7WRoq0gpkHDrC1HUlW0rjFaclW+VS0Nx
        QRTAlOIv6odazE9/X6QBOZGqwLE3tNUDCszC7nA=
X-Google-Smtp-Source: AGRyM1sJ8zzqTWIR/hUSpw0lEEt4LxTwEd4RY5YcycnwuT2xJ7q4LkJrRzW0sUXniN5EcFm+VuDHasB+m5SeMbpO6VM=
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id
 n11-20020a05640205cb00b00434eb48754fmr21898410edx.421.1659452742251; Tue, 02
 Aug 2022 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220727081559.24571-1-memxor@gmail.com> <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com> <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com>
 <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
 <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com> <99f39e29a9ca416cb005ba690c7d7e51@huawei.com>
In-Reply-To: <99f39e29a9ca416cb005ba690c7d7e51@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Aug 2022 08:05:30 -0700
Message-ID: <CAADnVQLgCmyJ1RpjuDe7-6NA_wu20NkGsLjD9B8WzShiXyiV5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 2, 2022 at 3:07 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > Sent: Tuesday, August 2, 2022 6:46 AM
> >
> > On Thu, Jul 28, 2022 at 2:02 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, 28 Jul 2022 at 10:45, Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > wrote:
> > > >
> > > > On Thu, 28 Jul 2022 at 10:18, Roberto Sassu <roberto.sassu@huawei.com>
> > wrote:
> > > > >
> > > > > > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > > > > > Sent: Thursday, July 28, 2022 9:46 AM
> > > > > > > From: Kumar Kartikeya Dwivedi [mailto:memxor@gmail.com]
> > > > > > > Sent: Wednesday, July 27, 2022 10:16 AM
> > > > > > > Similar to how we detect mem, size pairs in kfunc, teach verifier to
> > > > > > > treat __ref suffix on argument name to imply that it must be a trusted
> > > > > > > arg when passed to kfunc, similar to the effect of KF_TRUSTED_ARGS
> > flag
> > > > > > > but limited to the specific parameter. This is required to ensure that
> > > > > > > kfunc that operate on some object only work on acquired pointers and
> > not
> > > > > > > normal PTR_TO_BTF_ID with same type which can be obtained by
> > pointer
> > > > > > > walking. Release functions need not specify such suffix on release
> > > > > > > arguments as they are already expected to receive one referenced
> > > > > > > argument.
> > > > > >
> > > > > > Thanks, Kumar. I will try it.
> > > > >
> > > > > Uhm. I realized that I was already using another suffix,
> > > > > __maybe_null, to indicate that a caller can pass NULL as
> > > > > argument.
> > > > >
> > > > > Wouldn't probably work well with two suffixes.
> > > > >
> > > >
> > > > Then you can maybe extend it to parse two suffixes at most (for now
> > atleast)?
> > > >
> > > > > Have you considered to extend BTF_ID_FLAGS to take five
> > > > > extra arguments, to set flags for each kfunc parameter?
> > > > >
> > > >
> > > > I didn't understand this. Flags parameter is an OR of the flags you
> > > > set, why would we want to extend it to take 5 args?
> > > > You can just or f1 | f2 | f3 | f4 | f5, as many as you want.
> > >
> > > Oh, so you mean having 5 more args to indicate flags on each
> > > parameter? It is possible, but I think the scheme for now works ok. If
> > > you extend it to parse two suffixes, it should be fine. Yes, the
> > > variable name would be ugly, but you can just make a copy into a
> > > properly named one. This is the best we can do without switching to
> > > BTF tags. We can revisit this when we start having 4 or 5 tags on a
> > > single parameter.
> > >
> > > To make it a bit less verbose you could probably call maybe_null just null?
> >
> > Thank you for posting the patch.
> > It still feels that this extra flexibility gets convoluted.
> > I'm not sure Roberto's kfunc actually needs __ref.
> > All pointers should be pointers. Hacking -1 and -2 into a pointer
> > is something that key infra did, but it doesn't mean that
> > we have to carry over it into bpf kfunc.
>
> There is a separate parameter for the keyring IDs that only
> verify_pkcs7_signature() understands. Type casting is done
> internally in the bpf_verify_pkcs7_signature() kfunc.
>
> The other is always a valid struct key pointer or NULL, coming
> from bpf_lookup_user_key() (acquire function). I extended
> Kumar's patch further to annotate the struct key parameter
> with the _ref_null suffix, to accept a referenced pointer or NULL,
> instead of just referenced.

I don't think it's a good tradeoff complexity wise.
!=null check can be done in runtime by the helper.
The type cast is a sign of something fishy in the design.
