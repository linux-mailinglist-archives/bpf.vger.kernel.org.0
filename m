Return-Path: <bpf+bounces-9738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5379CE21
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008E41C2149B
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08426179BD;
	Tue, 12 Sep 2023 10:18:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7A17994
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 10:18:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF921723
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694513921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oucudl+k5IeCt8bSPR9EAaN7OT3eWorjofAbojhI4aE=;
	b=OVAjADK76J5rmhxnmhk5Yh8HxQkd7FM7b12e705N1b7J+VsJ9b4DjoD2QdhakdSmrQQ6LA
	yNKt9FghvvkrctcLP9yLeJEDjXVkg+8EHqnP+G8FEUEY5PaLqEKpKpTu6tZhVoCDNMin65
	G/A+dWCtSHxbFfluK5XfcB/6K53wa+s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-CJOBKFqvNaS-uXKoc6ChGg-1; Tue, 12 Sep 2023 06:18:39 -0400
X-MC-Unique: CJOBKFqvNaS-uXKoc6ChGg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52c0134dfcdso789466a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 03:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513918; x=1695118718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oucudl+k5IeCt8bSPR9EAaN7OT3eWorjofAbojhI4aE=;
        b=pvtETTCEq5YEr0qaKq/s0qqyDMMjShQayXF7oA9xHoC19SxUqNy0v8TCqdiOwx6ROa
         On+t0J7uWIw2A6aM4m7guXNadPZicmnDLICJApljUzEX1XuZqK4LB2gr0aq7aWLngbB4
         26DYZKMIn1m3KlpRoHFClSwnoFVzL8IFg9Ao+9lRZOhS5omvNoumm7PplJA37ZKsn8aZ
         fBJhWLZ3bahJHAEghCD4jgfVufF2jnMlnC17AIXOBEfaERFdlFku6ZKi5M+4qZ/qTd5X
         BBDw1XeXIst+dMXq5R0cemKsHh8lUYwk1zUUHBlCg29lXSs6K4ezdxxwwOCxDdtYuRDg
         tT4w==
X-Gm-Message-State: AOJu0Yyf2R6yLliorwpJueACPFhgc3fkbIde+YuwFZgHtfp6b+rMstwQ
	6VEB7eVOaGaO2R6cZtvTAQSi8xBCUloKAC+ipAmQrTvEw01zEXvJEn3h8Tex++5wvP4qNCcdHvN
	g9ZHCScD1b2kl
X-Received: by 2002:a17:907:971d:b0:9ad:786d:72af with SMTP id jg29-20020a170907971d00b009ad786d72afmr2092906ejc.5.1694513918693;
        Tue, 12 Sep 2023 03:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKwCMgpdBMyoyLEjev3VQygvMbQjCTrvrmIP82YAFTOsxsVft5rlwggdRA/8rvn4uqVVCjZw==
X-Received: by 2002:a17:907:971d:b0:9ad:786d:72af with SMTP id jg29-20020a170907971d00b009ad786d72afmr2092894ejc.5.1694513918370;
        Tue, 12 Sep 2023 03:18:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709067e5900b009937e7c4e54sm6681815ejr.39.2023.09.12.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:18:38 -0700 (PDT)
Message-ID: <ad61e3fffdfb899d57307b2bddb2226a084bcb65.camel@redhat.com>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
From: Paolo Abeni <pabeni@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexandre Torgue
	 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, Daniel
 Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>,
 Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>,  Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, NXP Linux Team
 <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Samin
 Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
Date: Tue, 12 Sep 2023 12:18:36 +0200
In-Reply-To: <E1qfiqd-007TPL-7K@rmk-PC.armlinux.org.uk>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
	 <E1qfiqd-007TPL-7K@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 16:29 +0100, Russell King (Oracle) wrote:
> Add a platform library of helper functions for common traits in the
> platform drivers. Currently, this is setting the tx clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

FTR, two copies of this series landed on the ML. I'm marking the no-
cover-letter version as Superseded, but please have a look at the
comments there, too.

Thanks,

Paolo


