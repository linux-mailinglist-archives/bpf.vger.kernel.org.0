Return-Path: <bpf+bounces-25-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A486F7774
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32A0280F18
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A83C124;
	Thu,  4 May 2023 20:51:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F7C
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 20:51:24 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F211579
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 13:50:58 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-42e3647a43bso330106137.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683233396; x=1685825396;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFh1U0R3+esYxAdZBJ3PskCDdFA6WRecQoZAv0Spsqc=;
        b=SUKGjX9gX5tDC1H45eeZqp5wGoFB9t5baB14aulxqf1AUtvK5Utq194ya+X06ww+bk
         6y8hvBRisCPFLx3Srg+uoH5DCY4VJ1gvY0MiGwZMXH2omseUNghoSjWyyIykHmMpXOsr
         dRiBZgURXCJeG2KuHakKgxRxHdJRKI2NVqOgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683233396; x=1685825396;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFh1U0R3+esYxAdZBJ3PskCDdFA6WRecQoZAv0Spsqc=;
        b=SrNUbntcex1/Mi9/bR5UGUjD9ON/JEJLRQs71nuIzzDQAMj/IHDPr3HMb+Uiv8PwJB
         HCDEpWxnxYrBFLVQ2QeDQ6xapy6hD8z1NKSbHE/dRkitEuXAa/9EedBIDQDrlLcI1yol
         CYKJ78Yjqoqv4v9y+7BonkOkA7Ubz+isVnDGmNScWx/4n83CydjQKKTwGY51ftrFF9xd
         pV2PNF3iZSIN+REyQpQiumsIu0GDyI1GWFUMgx78MIWdwe7WE6Tb1TMVx4KtqfIauqmg
         4HCe+1Q1OQWDKCeC3Zr4p8hDi57oQnL5yk1TjUw7nlEE+uLn2DfWRzcmpYMjJ61H7Zy2
         9RCA==
X-Gm-Message-State: AC+VfDwQ/LmS8Le6IOBkmA1COWYDvDPkXsNWmbaWnzRNcM4MpW5LSjUD
	P6rBmbfvxD5yhpDWpN/tv+5dbfgtbEvCwuArEZx/Nmv7zGE/NexP
X-Google-Smtp-Source: ACHHUZ5BV213HDD57+eKbdDaMh/gdgDBfClHPIMSCe0XKdLAyPuZXFPQonx4Fpla55EeQIhCy4Lc6xqbFrjOnEb3mtI=
X-Received: by 2002:a67:f948:0:b0:42f:f7c2:1a7 with SMTP id
 u8-20020a67f948000000b0042ff7c201a7mr3212703vsq.13.1683233395976; Thu, 04 May
 2023 13:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230504-repave-oppressor-82955e@meerkat>
In-Reply-To: <20230504-repave-oppressor-82955e@meerkat>
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Thu, 4 May 2023 16:49:44 -0400
Message-ID: <CAMwyc-Qme-ZuxrRgpBTS0zuhzc4FmHTAGTLZRjsdbwSVtGhRdQ@mail.gmail.com>
Subject: Re: [ANN] bpf mailing list migrated
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 4 May 2023 at 15:32, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> There will be a small interruption in archiving later today as I migrate it
> to the new source of truth, but there will be no lost messages once the move
> is completed.

The archive migration is now completed as well. This message will
serve as a replication test.

Best regards,
-K

