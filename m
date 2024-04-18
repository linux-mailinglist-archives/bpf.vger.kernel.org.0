Return-Path: <bpf+bounces-27138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A58A9A52
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F391F212E6
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452315FA94;
	Thu, 18 Apr 2024 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="Jkp+txBa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="cnfONtnL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VI20Qdw1"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765B15E812
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444411; cv=none; b=u7p3cKMpc9ebFBIDrMSpPj2D9/QCpFNbngVVlE/Ke6viHKLtTyZHMb0YzWLWPamMcdfqETBwe+CmAwMPejmsyEKTY4e9i1jF3HIb6DgkXB3nfRf5I45iNUsIAuXvdUo7Zo2PdIZNKGw4htccpq6QoYt3FjirIkOnCuLABnADljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444411; c=relaxed/simple;
	bh=A28IuvF99AJUY3UfWClVHO3IQHs6YzhCkyAjGTp5dGY=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=V92bCE9zOb4EI350Q5vyJ1zwjRljXyi04xZ/oixwvS8zldOtHW7Kj2YR4cy09M0ZBRkqqXA7j7UQqzQ1jlyZPU4yYC9WvDmGNK9mfUjk39dSqz68b+Q/cXoMU8i4ZCSSVBiAgbT6Lj+jBbm5NHA4UMZbgZM0hJdrWSlqirkp9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=Jkp+txBa; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=cnfONtnL reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VI20Qdw1 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id CEC55C151990
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713444408; bh=A28IuvF99AJUY3UfWClVHO3IQHs6YzhCkyAjGTp5dGY=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jkp+txBaKyhVxcTGl2PFw7lBPOvnD09ZoyrPF3E/UqLmZXVlB46i/CJRU4+SDOmtH
	 Rn3L8ovBEeeVKJWQ5RQArZq69ASEKlzs8HKujkxBS7Xi0ezE5/Vw1G48yyjWNI+3US
	 6Ns1In/DNeoKLZd0keo9nXTEyxttZhdLIwZ1vC/8=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id ADF26C14F6EC;
 Thu, 18 Apr 2024 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713444408; bh=A28IuvF99AJUY3UfWClVHO3IQHs6YzhCkyAjGTp5dGY=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=cnfONtnLfz8qWQeK1pZqLPpCg73DMDzE/wVbDGZRhlKDDX/KKq9L3Y9rY7iz/Kp5x
 IpoptxnRqBtAQCnfDNI4ti70nLA209e0DwM+0GWh8Wss6C+4frPDZH67yDV6ndkcPZ
 jgokHlIyhA3l06oTYxEcXms4WYjodxksB9MlGN1Q=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2A055C14F6A7
 for <bpf@ietfa.amsl.com>; Thu, 18 Apr 2024 05:46:47 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id huJSj1FSFnvj for <bpf@ietfa.amsl.com>;
 Thu, 18 Apr 2024 05:46:42 -0700 (PDT)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id ACBD7C14F6F4
 for <bpf@ietf.org>; Thu, 18 Apr 2024 05:46:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2a87bd53dc3so710113a91.2
 for <bpf@ietf.org>; Thu, 18 Apr 2024 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1713444402; x=1714049202; darn=ietf.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AS5SxMXGcrO91LnCOcUj7QnqlzGCqZXoeT1579YFhr4=;
 b=VI20Qdw1brYzzAdqibfTcXrj68m9TaQ1X5Jbr8WBcH5jmtlS/wHaaHZBIfmIqPDKUo
 nO8GQdrzPJavJISlgZNGrwshYFOcImlFfarGn3YYXzokHKFdlrd6x5oMfTv94mlI3sFo
 XHWu3fNWky88sgOMF0lTr1sPUMG3viIdGEJfl1HzAuPQngj3Vryo+QqtEQje77f+vreg
 FTTSYkjmg4QrFcuWgSrRBOrMuco2TFII5PdzuDFqgXV59922aaR/TmJwOM6aVt6TPVKB
 JikJIazBfZVIz7n4gshI4i+z8d6NQR6ozzDNhUh5aMLSIrHZkIJ677aW8Lj9m1Q+II3I
 ucbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444402; x=1714049202;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AS5SxMXGcrO91LnCOcUj7QnqlzGCqZXoeT1579YFhr4=;
 b=E883vPjAh08M+2/GYU4c/rPMPVbg4dhUp/O7nTvmva7YzdzUf53Vcu7MyoxIkzLitX
 BhuVDtKBC2WqckpBnWP6YInOGWS7zGhxkvT9nrmpyGzxtqLB1yhNHaSMcCmiFdNU2Spz
 L3BtzjXsvD3R+kXP9HFcnioAfcqL4rAbdS3WJWJd5404SiEWKP6LkzA2QzOOVvB7wopw
 Ezl72lh9FxLWSFRsza3N0z9Fq8SwyNzk0RAlIe3eABwfpGGrmv21+7kqo3Kb8UpAh1RE
 MMhNwFBg8Z+E3zYbs85LeoUracqG+devc1C4BzMxoG8YT0kgsFU1yOLVU73RfHg9UgxQ
 rShg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGV7GtjVLdPzSLUUdE3jEF7Z6HqGnWiOSDW0A/aEQBtwTJDyTf+5DrAMcf/3XtiQ2/ixBWkbNeyLEQask=
X-Gm-Message-State: AOJu0Yxq74FXwbrtlpYG7Dk4tfqwa1aB+7ZxfA2N71YlxrYQ6n+a2Zvf
 VUIyA+ZLjI4sQk+oPa8P+kagbOPNzwO/24ZsaUm+YtxggOE+IbYot8bu3L9B
X-Google-Smtp-Source: AGHT+IHGB2xteWs17x8CKXd6eMv3zNzPXyIlPHSItkrMfu31Xblx203SmlDGLi09a3r0trtmOUQArQ==
X-Received: by 2002:a17:90a:c688:b0:2a2:fc17:db81 with SMTP id
 n8-20020a17090ac68800b002a2fc17db81mr2326992pjt.40.1713444401673; 
 Thu, 18 Apr 2024 05:46:41 -0700 (PDT)
Received: from ArmidaleLaptop ([12.129.159.194])
 by smtp.gmail.com with ESMTPSA id
 b24-20020a17090aa59800b002a67b6f4417sm3089544pjq.24.2024.04.18.05.46.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:46:41 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
 <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: "'Watson Ladd'" <watsonbladd@gmail.com>,
 "'David Vernet'" <void@manifault.com>, <bpf@vger.kernel.org>,
 <bpf@ietf.org>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
 <20240405215044.GC19691@maniforge>
 <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
 <003001da8907$efd41140$cf7c33c0$@gmail.com> <ZiDFRI3sdClyG-dj@infradead.org>
In-Reply-To: <ZiDFRI3sdClyG-dj@infradead.org>
Date: Thu, 18 Apr 2024 05:46:38 -0700
Message-ID: <004d01da918e$74b407b0$5e1c1710$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGym9lSVor9R6wjkVDgbvdbCMHIbgJp4F1KApIu0eEBfB5hlwKy7T0BsXSL+2A=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/coUiD3Xg49-CeCBlppTh6Vo13sE>
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
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
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

Christoph Hellwig <hch@infradead.org> wrote:
> Maybe "static ID", or "pre-assigned" id?

I'd be ok with either of those. If I don't hear
otherwise, I'll create a patch using "static ID".

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

