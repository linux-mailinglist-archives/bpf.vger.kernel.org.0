Return-Path: <bpf+bounces-17346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3597C80BD52
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 22:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FBF280AB2
	for <lists+bpf@lfdr.de>; Sun, 10 Dec 2023 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF61CF8B;
	Sun, 10 Dec 2023 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UrJe14kt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="UrJe14kt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhYYoNQj"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18FE9
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 13:14:10 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8B36BC14F68B
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702242850; bh=sJkyiBvwitsjpnCDarXbb9tvudtmg5yj2zQ8Rl+afj4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UrJe14kttB6bjVNlJtc4Hg7cyDX3SETcB6uJH5ql7A2Hmcr2vgbbiQgOlB2dvMMxY
	 q9QVd2iuo2reY2gXwLdRC1q05LarjiUU0DQ6SsgUQ60Wyr/ShpJMHoR3Cg0W2s5oQZ
	 QRFac9Ptp39wmhOgrRbFtQw+FnagIRUV1xUpf0W0=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Dec 10 13:14:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 56F01C14F5F9;
	Sun, 10 Dec 2023 13:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1702242850; bh=sJkyiBvwitsjpnCDarXbb9tvudtmg5yj2zQ8Rl+afj4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=UrJe14kttB6bjVNlJtc4Hg7cyDX3SETcB6uJH5ql7A2Hmcr2vgbbiQgOlB2dvMMxY
	 q9QVd2iuo2reY2gXwLdRC1q05LarjiUU0DQ6SsgUQ60Wyr/ShpJMHoR3Cg0W2s5oQZ
	 QRFac9Ptp39wmhOgrRbFtQw+FnagIRUV1xUpf0W0=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 73DB0C14F5F5
 for <bpf@ietfa.amsl.com>; Sun, 10 Dec 2023 13:14:08 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.105
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HBjtbYTI-Z0u for <bpf@ietfa.amsl.com>;
 Sun, 10 Dec 2023 13:14:04 -0800 (PST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A3A80C14F5E4
 for <bpf@ietf.org>; Sun, 10 Dec 2023 13:14:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so3190279a12.1
 for <bpf@ietf.org>; Sun, 10 Dec 2023 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702242844; x=1702847644; darn=ietf.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GXDK4NPT8AOsFRt9zx3A0m9grq81nXyLEQqGa/oegKE=;
 b=NhYYoNQjk7Whyj5nHYuh+EZMVy4+/Cc0iOOruuDatqKLzXrylmi7R8MPVrrP/CUQnH
 5f+yzF0G9SrJprpvcrnXruxVeKkDzz0TAn3Y16aFerlI6pTBg9viwAM8ui1S5e5ZWq7p
 r7OgPmi/PdkzianfD2RQIK6LKIpGkO157XntjMRkV+Olp5Vmpp4kZTojLfNmSK1sGOhz
 QgLDu8A5XTEBq0/AD/D3RiVA7FJ2LMaCr1GFrEBVQbBbm2Pg3TSwH8Z+AsAqll+YCNuJ
 nePMNxwjLv8Cyv8oz96qfH/JXiqZNQYbdrpW/DwLJR88Hw/27rOUiaujjlBh04qexXBi
 Kk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702242844; x=1702847644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXDK4NPT8AOsFRt9zx3A0m9grq81nXyLEQqGa/oegKE=;
 b=XQrGbOhFpOT0pAEDR4OmMG7erb582/kxIpuzL1kMQKiRvolbiBD4W07SQ0yDuq1AHR
 OPnBbyUoUX+yoftAhAqKBrZjE2wOjMOq8vGjZPLpz6KvBzZd8+6M8vrthVNIa+G22qdH
 xGlP1Rnimn7dAkvez3lF2DampLvqfLES6ynhH9SLzmJd1yUQOI4cQ7FFz4JGrTNv3JX9
 pkTBp2O8qkcpVERQhxUVAMZ9RqXMltB9eHPLvb4Uc3HhQxLYk/bDpNwMApmRpevUrIVy
 5/HXs8hI5qK+L1TKFeX14kjoPbU58ZzqCD0/Dzb8EGagfOpbdkPzXOFRovB0NZ5rXjmt
 cZMg==
X-Gm-Message-State: AOJu0YyD5+SbvW4D2AqtF9dWWqHR3M6PoOj4Y9Vsb5IDa5RnUWh+aEKF
 KwEQAiYhcJeiZS9v5oAhbdE9ZBdsTVD4HvwEMQYCDrK7
X-Google-Smtp-Source: AGHT+IGcVi6zf4BkMmnx+BqLx9B6ugGY02+UOdr+AAS259vMUzp3EZhrExK7RFTfcMOmGIm7sBv5mnGewuTZDJ/u36U=
X-Received: by 2002:a05:6a20:3d93:b0:190:5faf:ea71 with SMTP id
 s19-20020a056a203d9300b001905fafea71mr4604576pzi.49.1702242843686; Sun, 10
 Dec 2023 13:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge>
 <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge>
 <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
From: Watson Ladd <watsonbladd@gmail.com>
Date: Sun, 10 Dec 2023 13:13:52 -0800
Message-ID: <CACsn0c=+H57dx4C17VNkzJaUF2cYeW33Vgq+72uPv60jZ4O8Hw@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Vernet <void@manifault.com>, 
 Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>, 
 Christoph Hellwig <hch@infradead.org>, bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/kQHSOOsxCIl_4lpSuPm6BHEMlIA>
Subject: Re: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>

>
> Hence my point: legacy and the rest (as of cpu=v4) are the only two categories
> we should have in _this_ version of the standard.
> Rest assured we will add new insn in the coming months.
> I suggest we figure out conformance groups for future insns at that time.
> That would be the time to argue and actually extract value out of discussion.
> Retroactive bike shedding is a bike shedding and nothing else.

If some existing implementations aren't supporting some of these
instructions don't we need a way to make a profile that says that so
that tools can know what they have to generate for things to work?
That to my mind is the reason we would define the profiles.

Sincerely,
Watson
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf



-- 
Astra mortemque praestare gradatim

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

