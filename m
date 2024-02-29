Return-Path: <bpf+bounces-23078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7D686D3AB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF46286C23
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD313D2ED;
	Thu, 29 Feb 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNjKHTuH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318F13C9CD
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236232; cv=none; b=Gxl/ui/oJxHb/1ZwfoyD+CHw1eVC49yPvVxqBtdQKlnMRWQosnR4Dx9h/gjkcvkQZwjjRQ9roJs5Qup/4NJxI2t1thPvaEfaFrcsfVAoBc6Age9z7sPGL0eUjOJySfTmyMX28jKeoDLHxEaonSZYLjPQtH8bzYcF6eaoXZGArfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236232; c=relaxed/simple;
	bh=XptUmnjF/eIdAZXOiHAt5HYS4MjOg251jRYbXBq32hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB0gXEYyp0y4dUMiusI3IRtVPq9n1P6IMuham3A6FqyLeLovAaEXkkenrxw05R7w6mlyKoGWjB2qCaa2Cpn4i4gkUAlNzR1obGsNf1y4rFHcUzOIdY3YRrzr6JkzHH9lhqOSk0T3/lQSjTfuG+cZYaXv/LKmdj51xEm4tAotWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNjKHTuH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dca3951ad9so12449725ad.3
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 11:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709236230; x=1709841030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRQcfbGLR30CIv0oVnzAc+UqUS3ZEuOt8WOzuRdB8o0=;
        b=XNjKHTuH9aRLskf6mE8akQFt5RGBR5v9ySa44M/lz25W0EYh4BEm/O4WgQEZPJUWng
         hXmUIe1kixJg5ECLIghu1Z63ZxPdHf2KI0zZlSf8TBzMGxo2xANComrg3yC8jxZzSuWl
         lPaUzGfQ2pXU59NMm4jZ6IDqRsnsoU2xQO+dgTnEUVZNQDw2lyQsHtiCN7FxHetqUgmv
         aTPo+9Q/ojKgcIkrKui0sZz1RYtq4wntuT973iGOS9xawdVTCHz3GbMlKyCad5zpNnYf
         pxxJZyTAGvzwiOLV6tVuvGdiZ/MdK4ZUS5t3z4PXEnLIciLPQ6cTziM3hlByQepJoAoY
         hjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709236230; x=1709841030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRQcfbGLR30CIv0oVnzAc+UqUS3ZEuOt8WOzuRdB8o0=;
        b=UpK7Fd3XTMhazzmt1369dJ5Hj8WZDM8O19uzH7Xzv3ZDrPfhTCCxWk/CuwqZaXfg/9
         m4Be4pcGLsUG51H4CSj6J9H3W7EjKFo5RrY0ZNujt0FpOLJld8FDboMP+tjLMT2PfGzB
         r4mycG++YsWVeQuofIQ7nB5V0zD8jfDZnznprNxwMgyPC0wnIMcdMNrcMD/fE4FusoqZ
         wutdkFN17NPrZMW9+TdIsxf3IR8QThASNbhtXX26Qykio/N1NKgiJx8iq+2mD6BtmgN5
         vluVBV1kSVooSEjU01lFHRuidjlUSeIQp7A+CqqVAlXnAi+87SjsnxzitDCpZ8PJ8k7O
         HM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXUMPCzjk0pRI7jqoW5FgY2DYDRn9gd5iMtdSW3PXt5TwqOAMS1VnM1cW2dbYemXNT9XytT33UGwft2QoMC5weNevJ
X-Gm-Message-State: AOJu0YzT5+nb6/bQatJdJ5tn052nOhdwBmhYRZ/PQwtYJL2i/C5nTB0D
	7bvIZt4AZ2JIYIH42mPM/mekOM0rIXkFv0z3UD9bU7oTgcAzJg7W+2nA0SncK3M=
X-Google-Smtp-Source: AGHT+IEb7AgLzFNln8BQIuXE8G4JzdugP/qqo+e51iz9f5DOe0hngenpUgdAMqd0xRRtONBD2C5W+A==
X-Received: by 2002:a17:902:dacd:b0:1d9:a609:dd7e with SMTP id q13-20020a170902dacd00b001d9a609dd7emr3457959plx.55.1709236229776;
        Thu, 29 Feb 2024 11:50:29 -0800 (PST)
Received: from valdaarhun.localnet ([223.233.80.13])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902900200b001dccaafe249sm1879433plp.220.2024.02.29.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:50:29 -0800 (PST)
From: Sahil <icegambit91@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of parent
 dir
Date: Fri, 01 Mar 2024 01:20:22 +0530
Message-ID: <10424464.nUPlyArG6x@valdaarhun>
In-Reply-To: <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
References:
 <20240229130543.17491-1-icegambit91@gmail.com>
 <d61e8537-e291-434c-b401-2b020b2b610d@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Thank you for the review.

On Thursday, February 29, 2024 8:29:07 PM IST Quentin Monnet wrote:
> [...]
> The error string should be updated, we're not trying to pin one object
> file here but to mount the bpffs on a directory to pin several objects.

Sorry, I forgot to change the error message here. I'll change it.

> > +                               name, err_str);
> 
> Formatting nit: "name" should be aligned with the argument from the line
> above (the opening double quote). You can catch this by running
> "./scripts/checkpatch.pl --strict" on your patch/commit.

Got it. I ran the checkpatch script without --strict, so it didn't catch this.

> > +		}
> > +
> > +		return err;
> > +	}
> 
> This block above cannot be before the check on "block_mount", or we will
> ignore the "--nomount" option if the user passes it.

Oh, I understand this now. The block_mount check should be done before any
attempt to mount the bpffs.

> Perhaps it would be clearer to split the logics of mount_bpffs_for_pin()
> into two subfunctions, one for directories, one for file paths. This way
> we would avoid to call malloc() and dirname() when "name" is already a
> directory, and it would be easier to follow the different cases.

I agree. I am thinking of having two mount_bpffs_for_pin_* functions, one for dirs
and one for files. These will handle the differences between dirs and files and they
can both call a third (but static) mount_bpffs_for_pin where the code common to both
scenarios will exist. The actual mounting and --nomount check can be done in this
static function.

> [...]
> We use err_str to pass it to mnt_fs, but we cannot use it here (it is
> not set by mkdir). We probably want "strerror(errno)" instead.

Understood. I'll change this too.

Thanks,
Sahil




