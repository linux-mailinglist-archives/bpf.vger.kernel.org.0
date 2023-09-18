Return-Path: <bpf+bounces-10319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A487A50AD
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB0281DDF
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E26266CC;
	Mon, 18 Sep 2023 17:11:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42111CFA7
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 17:11:18 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AFA94
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:11:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so2652387a12.2
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695057074; x=1695661874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yeTNGd2LZkBJrfVb0ETU6PRda2Olm0DUlIru7DK4sc=;
        b=FPeJg9m3rCoFNhaXd8z6uY47/zlNkcSuK3nGzkh/fVdyLd2f1bmLpGpdRfYh7zOIl8
         jTn19mIegwr4q3HD4mSTbKva4zFCwyxJYFWGRX15pYVPHFjvQ3HqvTeqdI9WVInHcUqo
         Sp2cXBhbOURVYnZ7apeliUxA2krRb/3bcMf8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695057074; x=1695661874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yeTNGd2LZkBJrfVb0ETU6PRda2Olm0DUlIru7DK4sc=;
        b=P+Zl4xhfqvuNzglQ7EgRxB0WXTIFJ0tYbEjiKzuyeyfOPcprOEDv/eJqfTWpoj8Aat
         +QYS2Hb3tKcgQbNifu5IcDooAyGZiRT8OdRBIR4+9OuI5OxCQC59P+0NHaV7KYN/9nsV
         gwNKQr/GDSILrMnc2u+WeVjmGzZ++catGMS4zZepS8UMqlN17FJ/exG9bXCXVfQR+RZB
         1RFG+5p5cXZCxcsq/jQZRyqmZ2kSzPZuBEZu2dG5cPmKpIjIKMGfAuUrvMpBdvS2CQgH
         Gd2WhECZTAdwZKn9p6OhTti0YG8iwRTlmR0NTp2AytCqDw1rFY8AHbUXNlVn490iCzvb
         EIwQ==
X-Gm-Message-State: AOJu0YwnXBYgaEzh2XCZthQKN0wP9gF7DvkrVjT9QtcoZAXM5PpZkQz+
	aRfbeGNHkZ+XQ/nEqUYSnXtyRJhpFMlHi5FuuX2Y0w==
X-Google-Smtp-Source: AGHT+IGmOF0p65tOnzbaLhy/F4INwFx/mzYSoVPZfnU5rNMEya3sje93jiUdu3RU/Y/+hJDGyv2MkHZQX75yNpoW7JY=
X-Received: by 2002:aa7:c708:0:b0:52f:6641:4ecd with SMTP id
 i8-20020aa7c708000000b0052f66414ecdmr8860103edq.37.1695057073454; Mon, 18 Sep
 2023 10:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918153611.165722-1-bigeasy@linutronix.de> <20230918153611.165722-3-bigeasy@linutronix.de>
In-Reply-To: <20230918153611.165722-3-bigeasy@linutronix.de>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 18 Sep 2023 10:11:00 -0700
Message-ID: <CACKFLi=B4BYXLpX2oU7uzyHxpFiQf0Adk14GJ_QZ-RUwGW-O3Q@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Gospodarek <gospo@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 8:36=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> bnxt_poll_nitroa0() invokes bnxt_rx_pkt() which can run a XDP program
> which in turn can return XDP_REDIRECT. bnxt_rx_pkt() is also used by
> __bnxt_poll_work() which flushes (xdp_do_flush()) the packets after each
> round. bnxt_poll_nitroa0() lacks this feature.
> xdp_do_flush() should be invoked before leaving the NAPI callback.
>
> Invoke xdp_do_flush() after a redirect in bnxt_poll_nitroa0() NAPI.
>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Fixes: f18c2b77b2e4e ("bnxt_en: optimized XDP_REDIRECT support")
> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

Thanks.

