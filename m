Return-Path: <bpf+bounces-7545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ADD778F6B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C161C218B5
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C128413AD2;
	Fri, 11 Aug 2023 12:27:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0441100DC
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 12:27:19 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F560E60
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:27:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso17814825e9.0
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691756836; x=1692361636;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MXKHeiw+hglC9ugOf63unP8EcYrU6d0alXF+kl+g7hc=;
        b=BZrDHyoOMPWEABi0tJAy6pupcUD+FXpgZoUu5bIuWitB5nrLCsFge2KmeqNTvxe/TL
         arZRt51uyxHd2tsXSlqT1iYb8W8H8ClwjSlauA0DQQ8x69/jJ41RNwXqhdYsCN8+0MYF
         A0LIR2u7mMN7MXqzLJnW3YeinN1w/6vFwM+HHC+jlOd2WNWS5N6j4iQZCuY8Z+XSiJrc
         22jnozEpJalUXtO4oL/8vg5/REXDHw+dMU/eltn+YrPH7elLDVr8T1RCziBsqbw9DySR
         sECYzPREwSW/UdQTp4FVMrVsCCezM1PTyiJUU0hwprQfMZ30ByTgsV8o0n2D8LsA8yY1
         etWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756836; x=1692361636;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXKHeiw+hglC9ugOf63unP8EcYrU6d0alXF+kl+g7hc=;
        b=WghBd8mKdP8O5DeFuScy/nk9SBKd4tbnDu7SwBTTCfXLlzqbSWiVtuI04toozp+8x0
         iod+SAKi9VAi2YArOHc3SKpOjshzUSoU8Gz96ZUzEO6AxbSd0n5OGquL94MxP2oLSmNF
         8JBaoTeQ2cPs6C3PfULW1MmaRi8suyjdci2xMnlm+NLV8+7LDWlkIKUC6a7zc0c+NpdK
         Dci/CgbQGbrEO/eOyXJmKpSyb47Vnh3mUds7nYnoxaZPXz81x4U2to4HsVuocDCjmfZ2
         6IDz3sBIWAjX1i2PjKP6fBqVw95+/PilM/UJerblMLXsTdyurlOFk+hO0YovuSe8vHKR
         Jp5g==
X-Gm-Message-State: AOJu0YzDM2s5jQYLh0V/nAviFebH5tWe7e4+pvQU30yBvhVouTlvt8H5
	IjJxUPeYovC4CkjbS4scI2M=
X-Google-Smtp-Source: AGHT+IE7nLL1qOXXSP7WuoeFSoYnoEc0jvJ/BZPrN0678HN68IbAtMda8WRrpgRZ1HREQNFwr8Vtuw==
X-Received: by 2002:a7b:ce94:0:b0:3fb:ff34:a846 with SMTP id q20-20020a7bce94000000b003fbff34a846mr1486911wmj.22.1691756836506;
        Fri, 11 Aug 2023 05:27:16 -0700 (PDT)
Received: from [192.168.43.113] (178-133-60-176.mobile.vf-ua.net. [178.133.60.176])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003fe20533a1esm5127031wml.44.2023.08.11.05.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:27:15 -0700 (PDT)
Message-ID: <53b775f90612206d709636561c73098cc0193d2b.camel@gmail.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org, Nick Desaulniers
	 <ndesaulniers@google.com>
Date: Fri, 11 Aug 2023 15:27:14 +0300
In-Reply-To: <48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
References: <87edkbnq14.fsf@oracle.com>
	 <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	 <87a5uyiyp1.fsf@oracle.com>
	 <223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	 <37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	 <87v8dmhfwg.fsf@oracle.com>
	 <7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	 <87y1ihg53e.fsf@oracle.com>
	 <48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-08-11 at 15:18 +0300, Eduard Zingerman wrote:
[...]
> > Ok, so since people seems to agree to the proposed fix, I will prepare =
a
> > patch for this.  First I will have to set up a kernel BPF development
> > environment... but I guess it is about time for that ;)
> >=20
> > Other than running the kernel selftests, is there any other testing you
> > would recommend to a n00b like me, for changes like this (code
> > generation changes)?
>=20
> What I do is run same kernel selftests as CI:
> - test_verifier
> - test_progs
> - test_progs-no_alu32
> - test_progs-cpuv4

Forgot "test_maps", sorry.

[...]

