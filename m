Return-Path: <bpf+bounces-53604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBBA57205
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798EB7A72AD
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2002561BB;
	Fri,  7 Mar 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccwRFuX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A9241691;
	Fri,  7 Mar 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376211; cv=none; b=T0/GCezIICL+89DTFZqSgxUEoYkeTSbNEVInRILzIT4/O9yjgTdeF2PnOrsKOXw7l3HXOrK66Vh8YsmSsbhekLwgcSiVB2ULMLMwtRoaFqugMajY3JD6pzu9Fpd/g5ek0fJvdE0XQGrprkT+w7UCstzDVDbTUPXdGPVqUJfprbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376211; c=relaxed/simple;
	bh=03HRd51TAJtBdjj5CN0yBCInrok2ztkJLZtRA9+zaFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3t4oloCywgMXfwaZDJbI5r4E+I+wM+4zCPZvo5sy3a1LCif363bKPDS7BuTGPYXBj9k9i2AVV8BtdLZ56iQgRAvRXP3MAHunVfDT9CN4si9Ky6pi2wkZakO6S3Dxm/Z0udz0D1Da2CgkvgNgR+J6LUJhkvIVrnSgZu8fyvvTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccwRFuX7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc38bb6baso13485075e9.3;
        Fri, 07 Mar 2025 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376208; x=1741981008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFoJyn4DTa2CPJIrOrIuaVtmodM0qzkMs+rPvEMHc5M=;
        b=ccwRFuX7jgmxL0rWRGmMMGg3xR7JmFRmpIHf6MR3Iqwbz0yik+N3OO7FDwhRWqsRUH
         UC/TarJ1PmREAPcu5liacHBiMYgzd61m74CqcNlA0m+ClgZtjb8pQgIE3LT1LlZaMkn0
         n1YiGEXIFn+NGtrX/HUePibqE8DScsSnnKJMLxesway2yW4RJW2GG8/GSz8e8ttgRYKn
         6x5SRSYS+uUadk5ycdpn2kEMPeo4Prlbbf+mDW7IUGSOj3Ge9kyhjULB9EaWNNQqziFG
         XTtX2rE/d0pnI0nrctUCM2KaU6/aGrJXGHyfm8JGGTb/njOe1K0td1Djlf671pbFWF4I
         16JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376208; x=1741981008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFoJyn4DTa2CPJIrOrIuaVtmodM0qzkMs+rPvEMHc5M=;
        b=Fl7VLLdYTXyB2g/eumlZuz9o+kR+HbxPyT68UX+Lf/2L359XJmP/pLZFqm5TBNalCj
         4b3r9N3QU2F6ug8eRFM6QMJZuPlweFOiR88QNvtwKXu1Fj356N5tSXNmLDv4uSHyyKEd
         y9dX/MfLIQ1Uj6IZiY5GnMQVhVlR7PKjnoARba9unXlzcWiudh4wfsR75Ul5cvCFjqD1
         l1KSZ/07RE+FwjOUuYcgU2GZXdtUTT3Pb85zzupSTueoWf4k8gofqm0M09NvlSkbva/R
         A6XGRVvx2RWJFsCgCmX9lrwvh8XYMdu0Kn5MTKizVWeN3Kz0XoLm8DPKDA0saGPuzfw+
         fsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUR27zvj6cLDFjYRbsmAf6Sq8p6zlkQNLp/2vPOK19Eg7dRKHULdl8YnF0Mwl7/0Li8QoRyo99NeSO4OVth@vger.kernel.org, AJvYcCUTdSVT+PCmqKOO+LZgicqEpsEKgMq4G0MZrUFzm39RP2r51uWAdIYW6cSmIVKnNzZEdD5cm6vR@vger.kernel.org, AJvYcCVJ1RD1/Zu/TxiSyKItpa/c8SAs6zQOjpVrcaO9Co62auGk9wQmkt/vI42mXoT3UJBVw70pWfWoldRjnJ6FnCM=@vger.kernel.org, AJvYcCVg0k+jpUiUrIkVLtLGV56JAcMYa+Jd2ksh4CyfPqAHVtkQ5c4iVhrcfETPJl5QixIs0UiI6lKxStF+PTUo@vger.kernel.org, AJvYcCWO3nhVS5cWUn7CRs5cv7H35wvRO6visk0hAAPAHo8q7jfG9iN4xa/6KH3tn6CPwIS9b9TTuGnteK+3eLw=@vger.kernel.org, AJvYcCXJ/3JBcou8HS6GT25y4SlcaKs+kk5sX1kg4ZQSruHPr6Jdhqnwz38UCs+zSlDl69J02JU=@vger.kernel.org, AJvYcCXdCZhwtPb53EZdQm6yyO0vpDbTuqYV3GXClhKhuPhG/43bZAoXpjpfoq7Mw+vMsjpDdspOh7/DfYRozsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4Zk1OkYatfbMbWXHTExWGfLrJbtjEZ0ostxd1hXU2feLdv6K
	rD36udqY4YQs6PjoyPGPEPAyY4armieq5OFhbU8+99rTYODVyi3x
X-Gm-Gg: ASbGnctCS/uEIKcq93Ic8/wKVV7YS6RPkqc5zHiO745dek3H+WpcBU5ak1vGUPlD/8G
	6USc287t7uo5SOB+VrmaZ0DgtZe3R5fVPYS8e5DaYl7n1Jf7VxSTBwTkLyAQWFWheEo+5uza9dI
	6BuXgtl0tmsGO3nEaAg4ZQshqaC68Xfwe5EelxS4l/DEJTaDZgwm8ik/CWvpAd2FyxQxP5DXEzP
	NkX/CI/k6VN221s4K7e3LAmZ0ToLd6UfsaOxN3eOsGsbQSvHvwkX32Y9j8olmqBF9AY/GROfuhs
	qY50mg1Amt8PggNyWC9zwamznimmNAzR/xb9YB9oALdsiBlzkFiDkNxwf1HOS2CcgsFCuu5JpD1
	h2lXmito=
X-Google-Smtp-Source: AGHT+IGYxYOhWA1l6Gh+krzanMxcdhuAnlJytBsEAg4OGnrOW8+O9FUNnMqzwJ9p5yYRvsqSKnj7Zw==
X-Received: by 2002:a05:600c:3007:b0:43b:c034:57b1 with SMTP id 5b1f17b1804b1-43c6024be64mr30043695e9.20.1741376208006;
        Fri, 07 Mar 2025 11:36:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1030cfsm6392462f8f.90.2025.03.07.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:36:47 -0800 (PST)
Date: Fri, 7 Mar 2025 19:36:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, jk@ozlabs.org, joel@jms.id.au,
 eajames@linux.ibm.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dmitry.torokhov@gmail.com, mchehab@kernel.org, awalls@md.metrocast.net,
 hverkuil@xs4all.nl, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, louis.peens@corigine.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 parthiban.veerasooran@microchip.com, arend.vanspriel@broadcom.com,
 johannes@sipsolutions.net, gregkh@linuxfoundation.org,
 yury.norov@gmail.com, akpm@linux-foundation.org, hpa@zytor.com,
 alistair@popple.id.au, linux@rasmusvillemoes.dk,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mtd@lists.infradead.org, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-serial@vger.kernel.org, bpf@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH v3 01/16] bitops: Change parity8() return type to bool
Message-ID: <20250307193643.28065d2d@pumpkin>
In-Reply-To: <a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
References: <20250306162541.2633025-1-visitorckw@gmail.com>
	<20250306162541.2633025-2-visitorckw@gmail.com>
	<9d4b77da-18c5-4551-ae94-a2b9fe78489a@kernel.org>
	<Z8ra0s9uRoS35brb@gmail.com>
	<a4040c78-8765-425e-a44e-c374dfc02a9c@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 12:42:41 +0100
Jiri Slaby <jirislaby@kernel.org> wrote:

> On 07. 03. 25, 12:38, Ingo Molnar wrote:
> > 
> > * Jiri Slaby <jirislaby@kernel.org> wrote:
> >   
> >> On 06. 03. 25, 17:25, Kuan-Wei Chiu wrote:  
> >>> Change return type to bool for better clarity. Update the kernel doc
> >>> comment accordingly, including fixing "@value" to "@val" and adjusting
> >>> examples. Also mark the function with __attribute_const__ to allow
> >>> potential compiler optimizations.
> >>>
> >>> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> >>> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> >>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >>> ---
> >>>    include/linux/bitops.h | 10 +++++-----
> >>>    1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> >>> index c1cb53cf2f0f..44e5765b8bec 100644
> >>> --- a/include/linux/bitops.h
> >>> +++ b/include/linux/bitops.h
> >>> @@ -231,26 +231,26 @@ static inline int get_count_order_long(unsigned long l)
> >>>    /**
> >>>     * parity8 - get the parity of an u8 value
> >>> - * @value: the value to be examined
> >>> + * @val: the value to be examined
> >>>     *
> >>>     * Determine the parity of the u8 argument.
> >>>     *
> >>>     * Returns:
> >>> - * 0 for even parity, 1 for odd parity
> >>> + * false for even parity, true for odd parity  
> >>
> >> This occurs somehow inverted to me. When something is in parity means that
> >> it has equal number of 1s and 0s. I.e. return true for even distribution.
> >> Dunno what others think? Or perhaps this should be dubbed odd_parity() when
> >> bool is returned? Then you'd return true for odd.  
> > 
> > OTOH:
> > 
> >   - '0' is an even number and is returned for even parity,
> >   - '1' is an odd  number and is returned for odd  parity.  
> 
> Yes, that used to make sense for me. For bool/true/false, it no longer 
> does. But as I wrote, it might be only me...

No me as well, I've made the same comment before.
When reading code I don't want to have to look up a function definition.
There is even scope for having parity_odd() and parity_even().
And, with the version that shifts a constant right you want to invert
the constant!

	David





