Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFD5519B1
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiFTNFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiFTNEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 09:04:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD10167E6
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 05:59:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fu3so20947330ejc.7
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=YeAJ65TAhJhjSBRZnr227VyJ5Qt4DLw2yf7fk1pahig=;
        b=qXJtXhGqlN16behyooyM1csz38krqTMRexCFQga/INfvRffXatTYXnZqHM6P1fy+Al
         mBdxyB0FfrnG6w1TvRykQsvhBv+VMKpOf671m06lNmpWqvE5TaxFbH/VvWFWaSsQnR1g
         FOzVOx1mGinyrYJ6piN7c9KE6wzF7wNs6woit//dcEFHb7EKAz9mGnaGnU4GvZCR6SoV
         z9WAXSkZMxjvw2nhI9dtB8zDEPOIGUwAsYBK7ZpWEo/NxJthfvHHpN3zk2M1pHE68TvN
         bdJu/DhIlsgZ8un3RsU0WSEkhp0q2aeSC2U3xTYaLSp3QsJGNNy+O4GRdiKzwt7y5mCd
         KhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=YeAJ65TAhJhjSBRZnr227VyJ5Qt4DLw2yf7fk1pahig=;
        b=nOv40ZX+CS02flXCnULHOle8WQv2uA2gvicJsXLvKzxTQimtCC/PYfTv7qGK1aOK8e
         QM7K7Mr/brlazJcdecelC3rkDuKthUdr7xWQdhp1ZlfC5DPgq5BK8I+jLZ3jjhJra17f
         9widqBZQMQaxl2wJkI8MwZMnAiugsR+nYGZM6nBCz9rJ2hnNwxY+evE6Cq4by3DIavr3
         CvBHsq2qEDCnPt9dXJan4QfGwHvxwOHwNQKQhReFaAy02sejTwhDQnM4NOujX2vViTbl
         pYkVoxnkyGwR+FB4JJW83xEtX1IrY+dLP9/fpdHay8RFNER0leG48/xxxRcxES2kqm9a
         KcGg==
X-Gm-Message-State: AJIora/JXdDhmzNXuiS1Y2kT1ITxmsHn06nwlyttGAT8hVBDX3OXA4XV
        LzTkvnFXd/kti9vFwYkr5Zo=
X-Google-Smtp-Source: AGRyM1uQJqx4nkjXlRzw6ExMZOt+mz4J2xEtbt2b7RD1gf09E6JTFlbTOzVyXquKqWpkX9QEMwzmKg==
X-Received: by 2002:a17:907:d8d:b0:711:d61d:dee with SMTP id go13-20020a1709070d8d00b00711d61d0deemr20590038ejc.670.1655729945858;
        Mon, 20 Jun 2022 05:59:05 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906293200b006f3ef214e20sm5918382ejd.134.2022.06.20.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:59:04 -0700 (PDT)
Message-ID: <fbe4fe4ae4f6f9db0d32208c0de8440647b24f91.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 20 Jun 2022 15:59:03 +0300
In-Reply-To: <CAADnVQKz7EFH+QGBtpO2j-MPNAAREta+GjHaKn2cN0LaNQk-1Q@mail.gmail.com>
References: <20220613205008.212724-1-eddyz87@gmail.com>
         <20220613205008.212724-4-eddyz87@gmail.com>
         <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
         <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
         <20220619211028.tuhgxmtivvwkzo7m@macbook-pro-3.dhcp.thefacebook.com>
         <b3441513293da1e7e25767446ed5c30592d190e4.camel@gmail.com>
         <CAADnVQKz7EFH+QGBtpO2j-MPNAAREta+GjHaKn2cN0LaNQk-1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Sun, 2022-06-19 at 16:37 -0700, Alexei Starovoitov wrote:
> On Sun, Jun 19, 2022 at 3:01 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > /* Mark a register as having a completely unknown (scalar) value. */
> > static void __mark_reg_unknown(const struct bpf_verifier_env *env,
> >                                struct bpf_reg_state *reg)
> > {
> >         ...
> >         reg->precise =3D env->subprog_cnt > 1 || !env->bpf_capable;
>=20
> Ahh. Thanks for explaining.
> We probably need to fix this conservative logic.
> Can you repro the issue when you comment out above ?

If I replace the assignment above with `reg->precise =3D false` the
verifier does skip the second branch with BPF_REG_4 set to 1.

> Let's skip the test for now. Just add mark_chain_precision
> to loop logic, so we don't have to come back to it later
> when subprogs>1 is fixed.

Will provide the updated version tonight, thank you for the
suggestions.

Best regards,
Eduard.
