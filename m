Return-Path: <bpf+bounces-13373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08C7D8BA8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356681C20FE7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5F3F4D4;
	Thu, 26 Oct 2023 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFADJU8L"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A82F502;
	Thu, 26 Oct 2023 22:25:55 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB63CC;
	Thu, 26 Oct 2023 15:25:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c5071165d5so16356571fa.0;
        Thu, 26 Oct 2023 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698359152; x=1698963952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k5p4Mh/OXx/If7dQQRvDkjUM/vaepawDRdGrZy7iw80=;
        b=TFADJU8LlltSRY6oRRLSdOJuohgM7xs+qDop6j+upcYoZlCuAmBkeRluQ5avd2iiSB
         JUNdkXUJwjbdP7DPYHZRS5AsY3zqDgOqZlnfubbkoWja+C4kVmzGz+j8lfZR+mKogJcE
         1M/+6tlLB7ftq2eAIj7nVKs69zPgEtisWI72z0p0Bzjnu3DtOKgiDwdblTIC9psNulR6
         5MmZTIbvH7+ZYe7H8o43CS/jBUlfjByqsgc3EyYsto43e54t90JXPnFS3lOhZ4imdJ8u
         ibM5YX/VAQswbWWu7WTJZIR/+2DDT2bpXFpIAKM2nLX3bSjwH/wkl7OA7y2Kdkmz8qhz
         tcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698359152; x=1698963952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5p4Mh/OXx/If7dQQRvDkjUM/vaepawDRdGrZy7iw80=;
        b=Dis/y4+BLOe/XIb2LxOZTymfeJHqk9EkyP5rZwixzYZ0t0Nh+vq7YtA+c8vmZihJ4W
         cT1u21MyJCto/Zm1nrfKJ/l/qOspiWI0JzpJaerAlwtC4GS6HSpkhhpKEnZ/FG0G12An
         lTGDPRvhV0WeLosfeWkvA1goqjBlbmZcDMOqTpna1lW80zNF1BSwkUxtFjM9reZxZ+r6
         1a1cZ/i/wR1x9kpmt5rb46DeL2lhghw9FnYXS65hVH6HvNpNEyKBCXik7z5clYMV3cU4
         sqLHsKsEjWiW9nh2rwtWqp7eZi9WiWdyMGDHPz1UWoUgBToM77HzmgzyPYrbVwX+A10W
         iGTQ==
X-Gm-Message-State: AOJu0Yzh7KVL4sE04dQ69eegXzCvgR9x/lBcUEVO8G2NB5ouDV5sj+r0
	26++CaneO6kHpjVDgeG9eOg=
X-Google-Smtp-Source: AGHT+IEo8OAfPWEktKMivKvhtgoDHKwvxythYXL179zpbTtMYmD2w6YdRdxd0nPaYjk3FRGKDLz64g==
X-Received: by 2002:a2e:8295:0:b0:2c5:1d95:f7a1 with SMTP id y21-20020a2e8295000000b002c51d95f7a1mr708686ljg.27.1698359152188;
        Thu, 26 Oct 2023 15:25:52 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id er14-20020a05600c84ce00b004064cd71aa8sm106688wmb.34.2023.10.26.15.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:25:50 -0700 (PDT)
Date: Fri, 27 Oct 2023 01:25:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: GR-Linux-NIC-Dev@marvell.com, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
Message-ID: <20231026222548.rqbp5ktgo2mysl6w@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>
 <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>

On Thu, Oct 26, 2023 at 03:09:59PM -0700, Justin Stitt wrote:
> Should I undo this? I want my patch against next since it's targeting
> some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> directly below ethtool_sprintf() in the source code. What to do?

(removing everyone except the lists from CC, I don't want to go to email
arest because of spamming too many recipients)

What is the stuff in-flight in next that this is targeting?

And why would anything prevent you from putting ethtool_puts() directly
below ethtool_sprintf()?

