Return-Path: <bpf+bounces-48176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F48A04D00
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 00:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2228D18876F4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 23:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101CD1E47A6;
	Tue,  7 Jan 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSQohAZd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB61F4E5C;
	Tue,  7 Jan 2025 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290933; cv=none; b=rtzLAKKAnQr7DUB7J++U0rMZAfQo5E2UOA7GeXhkNOttYgiRoGAACw2KMeUugUce5SxzbGx2TgraEnTJlsV2AzCrwuNz9Hxh+fTx1E6MgFJSd6HLq+ZjUmYsT1Uzs+1DuMYU5W+rsrG1nRnv9GpIbl6izX+v40HLqi36f3DbJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290933; c=relaxed/simple;
	bh=MwBS8WoKoqlrHE9RBWYu3gV6QERxX40yhERHlroiwS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twgo9RD484IKuKfZJQip4R6SStxM/E9l9+0d0/m1tJjLmkVx+BIJ6AVvPmjhdMl6jYIfPREgW5yTBcGJnr+EqsUe67+N9ycKCn1xNDaBrgRLX8r1Q3Cl15m7N4Gm1cKV6/hDOtESrNQQ8A4dVk0x9Hdg5RllsrC5+NxTAM2R2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSQohAZd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21634338cfdso23430085ad.2;
        Tue, 07 Jan 2025 15:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736290930; x=1736895730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxUtto18f/sIYqADrK6m7JMynq7JzrgYenyQ0yQtRlk=;
        b=FSQohAZdhrQROsR3I7gRza5FQFhQP02ETwYlAdJ0XXqR9gsAiMYfdm2drVIwBMbiKr
         0evoL5ZAQhF4Q84P8mOCBv3VTqDWGGZ16ZUblcriRP1FCN5ZAZLirpc0/2pLdPE0V7+6
         s/OyrlIUI42ZqFM5jBPHl8cXcWkwymbja6noswZMRAZWy6aRCJTviWvYXVUJePZ90LWI
         jaUsQxljrbnsUxdq1paXDo8NBIdiHTB72Z45nGn6uytTdcCMv2T/ZkH/R+4XTOFqZPxz
         d0LwWvUF1hURH88PxjgTBX8veTesCd85LHPFefN1rWsPGVXmImHuVQmr47ymmc2SxAzu
         7/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736290930; x=1736895730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxUtto18f/sIYqADrK6m7JMynq7JzrgYenyQ0yQtRlk=;
        b=wkZaQbU2IV0p6WTwuylSINVop2j0YRIAIq4FHx9SqvnNiKqA728ziO2y2QgVppk2ys
         /PJ1kRNfAFcDrSpjF487lsIT1Fk0d9r0v+2KhhaMQbxouTJW1yw0RBhXAb4HTQnrAhe+
         qM5JrSW8lAi05kWFovPvvozapuPA9A1nGGOv0H5yokPxr+UvcYPTxjCmzkz4AXuNmohA
         KONZIQRk0Gk1M7dtY1WX3HRLJ+lNHIUStHWYDCKGyktWFS2IBPeR3Deaj+PKiLRITbAj
         cgNiIjEBkyluOQgO+FtDQKZwfwGdFVKbc2KWeuUeQSXVMjWmAvoUkR5Ec2Spnj2qf/EB
         +shA==
X-Forwarded-Encrypted: i=1; AJvYcCUK0qdB+qJBjGL1Ju77+rdAGFUQTwSh48KjSird0WiWBa/CBLsSFR2XD117pTmkYIAzkeo=@vger.kernel.org, AJvYcCUWu1ZUfwyaUoMml1eEwZPsBIcOnRB0o7hsmbWCvdvbHrz+PCilEw9FTyqEu/8+qIttSUxQQy/S/SqV1djX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun466vvCN6wMiktd8iPBV3lhSZBatLtPYAjBIElemac3S/U52
	qvbVJXPBEZL4RADyVrgdNzY3zIprWVdoqr4C5Th9wOL43ffWdgM=
X-Gm-Gg: ASbGncuQUWjHhwZ367Z/GAMrE6qTcKKQTsPqGzBuTYi0lUKnCP8HfGKjFGAYRloHUeo
	yR0DVtb9EXxtpvPaJR0OA3TLOmfDtZoRHgGZBiSW02dt9ptXPDpTMyeX3nfrxmYbb9EdJCdlg0W
	dUuGEnmlDnGd1+wH4oPJUrFOaz2lMG8ZpTv7CQgUoxbVECZnsoZEM40GXngW/MWiKU/xuSZ15F9
	qYMC8yggtHicqhDCN8rgb1pl41xRIUJ4/s+is53wpkx5gj0eieKh1nO
X-Google-Smtp-Source: AGHT+IEdLNKjwtK2kBUOP5+4imhU4DEj8APQNFyHpnVvds+W8GWkS3nvLeueN4h/5tmJonMv6LHGmQ==
X-Received: by 2002:a05:6a00:3913:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-72d21f168afmr1019754b3a.2.1736290930008;
        Tue, 07 Jan 2025 15:02:10 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8faf93sm33873590b3a.153.2025.01.07.15.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:02:09 -0800 (PST)
Date: Tue, 7 Jan 2025 15:02:08 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Replace (arg_type & MEM_RDONLY) with
 type_is_rdonly_mem
Message-ID: <Z32ycDDCNTxavo7c@mini-arch>
References: <20250107090222.310778-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107090222.310778-1-yangfeng59949@163.com>

On 01/07, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> The existing 'type_is_rdonly_mem' function is more formal in linux source
> 
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Looks ok, but I'm not sure this cleanup is worth it on its own..

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

