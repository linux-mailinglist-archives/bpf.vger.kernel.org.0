Return-Path: <bpf+bounces-1432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E70715D1E
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 13:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF76A1C20BED
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960C17AB3;
	Tue, 30 May 2023 11:24:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8913ACA
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 11:24:45 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B0118
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:24:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso4170464a12.3
        for <bpf@vger.kernel.org>; Tue, 30 May 2023 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1685445879; x=1688037879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDFiw2NZ2KPcPpdOWrLyKHVOdaWV9rOrIcNk9rFAJRc=;
        b=i/QmtubuVM5MXH8DA6zZPIe05w2yzKv2VkvS6nhZLXeFg6+6ZtRk3/YDiN6HNB4425
         Tw3kt53UYfd2M1nPEFiZPz3+pJjC4PhSsA/DnFy9xARG6DXhHVsyF0WPwMPZF1p5xnC0
         3IiBJ0THyE1OohLscl0jiff0LCgQbT+nLP0wwfLx7qM+vV1GTIx87zgvAoc93RhW7ZQg
         LArelhyfYpfAvgMKFiYaZejvHJw9+CeKKqj0yyl+L5ZlcQxTQfU5mlhlmRAxopO6t0iU
         f9X8bBkOCBXmpPmHhs/CF+pImoecahnK2jUFqEJim2bpygqWyy6jY+6TB/ChFcCR8FM6
         vm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685445879; x=1688037879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDFiw2NZ2KPcPpdOWrLyKHVOdaWV9rOrIcNk9rFAJRc=;
        b=FXK+gsELwKhzniLurr/nqhnOZoLCIHDHNLO22HKdXa73jaVM7+uT/LVZ0LIQxvqHC/
         MzzJLio4Qrgu8bkk5UGj9K83t2pmeC6zQ+TaEg+5a4oR1n7j6UEtJnEC3jbCyy8KhIo+
         GqoS3seLF24ltMqnMBXkqkwIgQ46UBrX9G7qM+d3PuaYxnu5WJhWIB7deUVul1oxchLH
         sc3mhitT9ovSljUzwjjYsP9nbBJvIIC9e/iBkxJBoPYRU5yogf3keZq+PD5fJMx2RXua
         I9XWvCDWJW2NISCJOUMZrjYkLeYK6PitH2nFt05wvZpMF3jUAcwEwlHVqdnJT4RH8BfU
         yxLA==
X-Gm-Message-State: AC+VfDzYpg/6wHgBPOo9EBM1W5Pfh8LOnnmUdLbFObgykZ1iIrL9Iqy1
	t2+ThYVotZu/1WeiMcBrUsdMHCrMPQIbxiBDCXVfEw==
X-Google-Smtp-Source: ACHHUZ6/dT2hu/yep7lq+BIWR9UpAUh4DvHp9z8hf5OQTL0ymetEwXH+zNo8RGxKxATCFM3qtOL55x2t8vcbijVb6xk=
X-Received: by 2002:a17:907:961a:b0:973:91f7:5092 with SMTP id
 gb26-20020a170907961a00b0097391f75092mr2957498ejc.2.1685445879235; Tue, 30
 May 2023 04:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com>
 <ZBiAPngOtzSwDhFz@kroah.com> <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
 <CAN+4W8j5qe6p3YV90g-E0VhV7AmYyAvt0z50dfDSombbGghkww@mail.gmail.com>
 <2023041100-oblong-enamel-5893@gregkh> <CAN+4W8hmSgbb-wO4da4A=6B4y0oSjvUTTVia_0PpUXShP4NX4Q@mail.gmail.com>
 <2023052435-xbox-dislike-0ab2@gregkh> <CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com>
 <2023052647-tacking-wince-85c5@gregkh>
In-Reply-To: <2023052647-tacking-wince-85c5@gregkh>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 30 May 2023 13:24:28 +0200
Message-ID: <CAN+4W8jn2P9LtB=4FtWxFikmEdGGbaxBvUg7swkip+EzqfzHPg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, 
	sdf@google.com, error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 6:43=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> So what tree(s) does this need to be backported to?  I'm confused, this
> is a 6.2 email thread which is long end-of-life.

That would be 5.10 from what I can tell. Other LTS kernels have
working tools/testing/selftests/bpf.

I replied here because you asked for examples :)

> It can be avoided by people testing and letting me know when things
> break :)

Fair enough. Earlier you said:

> And selftests should NOT be broken on stable releases, if so, something
> is wrong as no other subsystem has that happen.

Why is bpf special in this regard then?

Best
Lorenz

