Return-Path: <bpf+bounces-65209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC14B1DAC3
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778CA5633C8
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A8D268C63;
	Thu,  7 Aug 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAPDJHfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32979E1
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580429; cv=none; b=uJ89kvGKMspkR88zg5+jfyjtG4MElfpTmo3JJtmR3QAJryzgS8jpbK6UbiHmU47W9wGbyarfsi/lWrplmI/hU2/OLjNsLDE3Bo/Iunf3suLvIbdZvcBF0kn/kTZwvj2qzW40NP9/MrBRBvc0COGrMUE/fByEE2DHXUtYTKuQgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580429; c=relaxed/simple;
	bh=eDpC6tIFxjwL3AgNAZuBML5lvr4it73eMxwOf2qsyMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmgGszvmuu0tbMLazC/BeeYeNXBvi4zv6bmxPMyRyUG+Cewkcyzv75j3hF9UtEH90e71ykWJZJThsU1HBPtDnX4tr+/Y3yVMuRvGPSy615jK/gBVt41BcuuEXM/UVOgb6jDFFgt0G4sEwIXfAjSa0M9M5HHrp7zKg9Y3ItsptJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAPDJHfr; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso214547766b.1
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580425; x=1755185225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eDpC6tIFxjwL3AgNAZuBML5lvr4it73eMxwOf2qsyMc=;
        b=lAPDJHfr/rfFy8+QOD4DvkCJwIP/J1qOdnIKkN4CjqtExMuZcGrvlgAvjSw75XXlxR
         +6BkyxOx27i/jQHdBodR6zs4Uyoh2Gdw47s/kLwODPrUTSUZtLF10zO075L6+vZdnDeN
         thdUywOH7fsvuz5bhZu8PHpIcONCdRw1og75zWfEbcwDA4IN2tRkZjv6oVSxaLnqq2kV
         /3xXsIa14ly0VMwn6xGp66nN8MVFlvwb2WZk5SDIyhcciHMf+pt5kTnfi+aPpKJBaMT6
         inWNBi+qbumzKCJhmJV9NwAuTOwWTAwlwzXiRP9aOUYvmOtOAiXsqQgIVmVI5FS899PW
         YK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580425; x=1755185225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDpC6tIFxjwL3AgNAZuBML5lvr4it73eMxwOf2qsyMc=;
        b=My4TKu1DgOrFYmVKrpDYZ30L40VP7/O1s/XwJOO0vwVZonJ0T0J6VWM4mi8voatDO6
         vavGxFB+V8btJnDjBeMmw0/oWZAtjoiIbsSGqeH0RfOT+PHGgAajPOzGThWjPOoPjOkt
         /XHQXpVGOqL7hYzxWwlbb5UhwC1fD4PzpL8hJqr2rL11rpx3szbNzQZEZb1lpOdQ9ohm
         gSaPjRjLbhDK+9SP4Z9vSezxMY2F6q/0Q6/oaVOWPdqcCYqW4fDqUVt0JAUVHUcMHIrv
         Jo+NxNo9nFkpKaOHQmdTU/a0fnZabBz8ZpzJwfhZTZ6OfthO5k/ISDcdsTeIjAPMpzj7
         npKw==
X-Gm-Message-State: AOJu0YwjjrVyJRDtCIV1FqBgDx2Fc0RUJmxqocYMIf3d9Z89uh07EHUj
	9Xk6M9ScMSuuvNYQLBdP7KdJbZh+CFRX+FOBI46hg0IJR9n3KtsoDd1YW4bEMGTVci20aG5P4l2
	ToKnyZaGSoUd+L8ysdFsnRKW+zJocmYA=
X-Gm-Gg: ASbGncvRDE2gB9xOtGZ2HmXkpvEaFKd1tKkfuhua8NRR3aU9BXOFNO57Wpk5scfVEEm
	tiyI3JlTt89NJAwGWgnTgVCPjezGqRuryvEE1no8d/wrBaEyMU8cV6ZI8m6mM3HBHsnspuYL0wj
	WF6igR60M17bCIhlHW3mahZB8JJ1Yf7dyFL0Z+z4PYUK7UeS3xFKkPFMGnxijCC9UsRVkvJBmRy
	vxrAT1kXrFyKNrobA3gL7aDqcFbpmr0L8WycBEPuDEw+rX/wnE=
X-Google-Smtp-Source: AGHT+IGDGPZFLqGqoJKiHG9EHiS73hHfzjFakLRCVlV1ROg75gcgaiqZFkVZDnjnIxQKcel/W85V4O21CfUO29pX0Nk=
X-Received: by 2002:a17:907:3e1c:b0:ae3:4f80:ac4c with SMTP id
 a640c23a62f3a-af9900498camr652502266b.12.1754580422648; Thu, 07 Aug 2025
 08:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807010205.3210608-1-eddyz87@gmail.com> <20250807010205.3210608-2-eddyz87@gmail.com>
In-Reply-To: <20250807010205.3210608-2-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 17:26:26 +0200
X-Gm-Features: Ac12FXz8p4aAj_26TARg7DKUXSp8tZShiWvBqJQX7xbzhjLCDg-oSdBE0nqY62Y
Message-ID: <CAP01T77MzWRWn8boOXnrt6+VJAmcziGiDkZYQH575=WZe4w87Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: removed unused 'env' parameter from
 is_reg64 and insn_has_def32
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Aug 2025 at 03:03, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Parameter 'env' is not used by is_reg64() and insn_has_def32()
> functions. Remove the parameter to make it clear that neither function
> depends on 'env' state, e.g. env->insn_aux_data.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

