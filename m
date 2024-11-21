Return-Path: <bpf+bounces-45331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510A9D479D
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 07:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955F6B20FCF
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 06:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA72155C9A;
	Thu, 21 Nov 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdjCCAWU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCB1474CC;
	Thu, 21 Nov 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732170891; cv=none; b=r+I03xLMM7LUdqIYaqDH9ycvNT9WOqET1p5PK2tRdURUuwO1HdKReLKHO9TWfIFuf5e8haZqBb0GMfcobVvN9y+0E7k6GqdNEJKPOJrcGo5H0xNax3GHEKwJyZk2+01XkOPA0MTMr1dPG0S+ujMrP6nVhrrh9arniYGOtK3rUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732170891; c=relaxed/simple;
	bh=CCJYpnNoFaP4PSwtx+JJstwBCvQf8IP9xq6B/BY7U7k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mHikSo+PwwtBbDCnusguS9o6To7+CyRMOdNadYheA/6ZKptXQhyNBWyGL6tcXpmidIbp228X1hK/SH8r4TE1Vk+8k1Dc6dBw4cLbG+tqpZs732fc2u4Il0lWkf6irPMlrHOPbNeQ7mgYqhMfXoMl/sIhJ45mB7Aq95/k/e9sdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdjCCAWU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21260cfc918so4016055ad.0;
        Wed, 20 Nov 2024 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732170890; x=1732775690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcbwmTLwIfF0uyzEPmfMHhi+eaHOIrhHi87bo0ww+6M=;
        b=OdjCCAWU4oWNYqIpGyb28ctc34sEPzUVOOwEArp9JfFxOAaKYiasScU4o6qe1zVWBL
         lzPYKBwMPR+SYYgCodbI500fmQ8CS9HEdSG9z4LTgFOcMz5ycF0PRjc+N0gssu2L8N7s
         l+qnXNWfA0jzKvQVRDoSr6m3z2OWEoftFuKSo/ProaqXErKmlP8/jNQGq4zKmOGaek6V
         qvhl5kxvV7KEtcS6fCi1Sl339NABadX3O+i60Ah5vm3iFsL2Cfks7+9EEvEGVNHjhHu3
         T5Uyd2vVsQpkqhqzTvUccGsI+Ayg97zy3aZeH3yMK+PlfMlvFGaiL6GxkfFnL6vDlqwy
         ZvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732170890; x=1732775690;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcbwmTLwIfF0uyzEPmfMHhi+eaHOIrhHi87bo0ww+6M=;
        b=n803uwXIDkqYVnuLy7l8N4YlEUVlS5jgMRaec1pqXmSvDHrth9kcahBbov0s43egQv
         bB50WrtduYwYFyRxPreC7B7OKrWfdbWm/ogJQJx5XRebR91+3hO7zl8QRKQmpV4HcBXo
         dVBJcScRNhtOY0upIMJvFBI6+oLx9k/iiEqfOpOcb7BkUuVXoJ3UNOxWN9KI3LpLu0jf
         6Zwlh80R/0ygdoy1oKbVlAT+bG7YcgYdzTLYazJxoOdBrepVMUTikyj9FrHRpEveaYnp
         LSeXpnWmL55mlfQZhWETvZn7jcV3BfD1byhJF9XgLz+eFQwjAioSelm3TLVi1DaprGKq
         JTNA==
X-Forwarded-Encrypted: i=1; AJvYcCUapA2WEjJA2GoGshXxdWzCRWrOBM4HyikQYONGepcVfTVfo/ISvXw0sR1lz/lrFX93/zpI3D9A3JF/Bm1+@vger.kernel.org, AJvYcCVXDhpFgkBaIHMnUwku5YRCWEdny0w/lNAeHBCVZixznmIoDaUMdgnuK4feRqj6jRJWxEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKE17q6AecPlMIfXqe8beCVhtEfd5NQkNyIaltJi7EHWmXFAig
	Rtp15k1AwJcjaDifrsC0D55/satr2Bh3vpARO/xHUlLsNiFUAE99
X-Gm-Gg: ASbGnctK8Im5vojO9NbnX9J6I4ISWbvvvQcRXUBfrd48RweGJbpQK9mBCHxlOVRi2JG
	M2mt1ibTy+C1cKR0YeloH6RkAqKNJIs5aGWhvIbJzWOoBqm5dT6qJOx8Gw0KIMUHZH6azhyaduS
	J/Cxzg4yqElU/gyacfMJpsvA0b51dm6zoshE1fX4EKt28Q9emmfPsIp8weZ8F1YU95L3LqfHh9w
	3QIJw/m/61pvUtNXr5PM+h8MM0TfgJ8MgkNCSsxbO79wFnesQk=
X-Google-Smtp-Source: AGHT+IFkmlVd18uw8U9dudkF6C+D/TZ9qT66mPffZJqim4Ux43xTlK89LhBU1qMqtrdo02x2/fQwCw==
X-Received: by 2002:a17:903:8c5:b0:20e:552c:5408 with SMTP id d9443c01a7336-2126a4551c7mr64693705ad.51.1732170889716;
        Wed, 20 Nov 2024 22:34:49 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee14e4sm6035055ad.147.2024.11.20.22.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:34:49 -0800 (PST)
Date: Wed, 20 Nov 2024 22:34:47 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Amir Mohammadi <amirmohammadi1999.am@gmail.com>, 
 qmo@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Amir Mohammadi <amiremohamadi@yahoo.com>
Message-ID: <673ed487b45f4_157a208ab@john.notmuch>
In-Reply-To: <20241116071346.1412266-1-amiremohamadi@yahoo.com>
References: <47225498-12ab-4e69-ac50-2aab9dbe62c0@kernel.org>
 <20241116071346.1412266-1-amiremohamadi@yahoo.com>
Subject: RE: [PATCH v2] bpftool: fix potential NULL pointer dereferencing in
 prog_dump()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Amir Mohammadi wrote:
> A NULL pointer dereference could occur if ksyms
> is not properly checked before usage in the prog_dump() function.
> 
> Signed-off-by: Amir Mohammadi <amiremohamadi@yahoo.com>
> ---
>  tools/bpf/bpftool/prog.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

LGTM but still needs a Fixes line.

