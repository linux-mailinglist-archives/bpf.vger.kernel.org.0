Return-Path: <bpf+bounces-35670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417FF93C996
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014CD282518
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088461FF6;
	Thu, 25 Jul 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YTYFMZ3c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC94D8B9
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939705; cv=none; b=H6LM45W/kkRgih6C3at11GyZfwL/GpVdm63y7r65YuMwNiwji2WjXyyLDn4IU7v1sn9Txl8JRhZ55BiSvN2TZuAOu6UHR7+zbd3vv0p9LA7fDIXlrNa0Y7nN27tkj68aHa9GFqtt44ZegvCKcp+q64Jt3MrruY6VFJhqBJsfsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939705; c=relaxed/simple;
	bh=+hcuACSrDnXuyK+3nXy13Q6NsIAr/YWO+OR5khRNjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSXVNGS64oAq4gEVBkeHp0j0ykOUIS8mD8ZuoKJJ3NWG13uFqJP5aVk4DAmR4874Q4kaugRXBdFtTPmSauuaqEE+psh1RPsv5N43ePtBR1/1s1VD4E3hwz2JXIOZ6OYRKmprlzsAk4MacI/hc2sbwRmdTp0+z5hxBby5pM+jM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YTYFMZ3c; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efc89dbedso760839e87.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721939702; x=1722544502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=YTYFMZ3c3gf56lfxm869KK+1IESMInS+OqGssJpHdDdLTeQ8xqPHG9J+zmu/GhYT0g
         Fv8vQesdQHkSO7b2ndGAvltDJyZMi05WiVWZ+fnSmEDnRUs8Rd6ah353W77R1IHf6Xg0
         dwvDCZc04nfEQkHHYbpe0QtbknW8nSKIx/A/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939702; x=1722544502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=XKucJqUSlC0nsMICOKsBmVWovdb70tmPruDrvdvoyvf0qBEZcGfrUz2SuanKsjUfrI
         DpZJ3ScARfLZlY6JDM/5EQ2tTbCsLMXPWMiAkvp4T7rJnL7hnW32QIMBb6aMHhMaPV7F
         ocIRaB5LNEeUlNss4hwqdKqT2ZlCpk1KCa3dTapXpUdkEv7hjoqkICRj1LZ/0QFa6cI9
         yUMsyCF6ZGcAdZRytN7mV8/JfUjpi2yiXAgnH0UtpvF+A17p56AvYkt0u1P2bSd4nqP9
         /uDuk6haBVGZutnN3xMZbD7EKCsY6db+M3LJoHCRiPjKO3Uxq8ldUOvPWTReO92LieVL
         P+WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuEv2sz2dYpNqsMDO8ZdhTEa6BIzS2LMxJ3ulQeBFgkSGEWyXKKq7RNapAz6SfjV7Zic2HPOQJzoAxcvGyAGMynA0G
X-Gm-Message-State: AOJu0YyKff85TAhcS4xMXIBrdSRD5JYbF+klM7zsLe62/KEjRAi+GDSF
	fGFberQnB1R+NnlfdfCVJnrSQzqd1msp12hMrhzDDFNnBkWlNjbKovLHMQKXHXFj+EQZRo45D5E
	Ikyk=
X-Google-Smtp-Source: AGHT+IH/73vDAT1LS6Twmjgg3PvHx4UcIpDzlWceoCTxGfTuzr5Y0gKULdrsvEYyypmK9VEU1di9PQ==
X-Received: by 2002:a05:6512:3c8e:b0:52c:d9a3:58af with SMTP id 2adb3069b0e04-52fd60f9cfbmr2317315e87.49.1721939702074;
        Thu, 25 Jul 2024 13:35:02 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc403asm310441e87.37.2024.07.25.13.35.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso7015371fa.2
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJRp7y3KZWO7v7+VCUbg2OgOuaTq9E3kbkY3+OMhafV7XmfTP5xYNvAfUfUVEXzNyPa6SN18f3I0Q2FBfZwnvaOgr7
X-Received: by 2002:a2e:91c9:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2f03db8e45amr23043301fa.22.1721939700903; Thu, 25 Jul 2024
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725153035.808889-1-kuba@kernel.org>
In-Reply-To: <20240725153035.808889-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.11-rc1
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 08:30, Jakub Kicinski <kuba@kernel.org> wrote:
>
> A lot of networking people were at a conference last week, busy
> catching COVID, so relatively short PR.

.. and here I was blaming people being on vacation. How very insensitive of me,

              Linus

