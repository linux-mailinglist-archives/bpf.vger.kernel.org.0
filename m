Return-Path: <bpf+bounces-45677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C69DA00E
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814E9B22E66
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B362F32;
	Wed, 27 Nov 2024 00:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZHbC8aI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2DA23;
	Wed, 27 Nov 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667714; cv=none; b=gV7E7W5mAUkOP5PxtbL+v91ZRSZMYXh+QpqhHB7wXHmbO+NNrD2+zS/ZNwtVPZ9QxaKBlxG/CEF7hDhFJJpU5OdyqgK8A/iyOh+nCIg2LNfiwoD8aHvRFU8NA0ZceMI3UMLOF7etvU6SMLrG8AYokpHxV0Haj90ZXpqoixLxNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667714; c=relaxed/simple;
	bh=wwEHHjeePOFS8sifKhXNpJZ8wSDgwVbUUuXuwR9Q1ZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGxFZ/rv0WTzBxl97IOTwzlXG4a/Sd7bpgQZpgLUe5TNx96S9s3e+9HJm9/9RoqQoonIazsdV6unHE+f6K6jJqWXTHVNofDNj+FhPTshR7D4gne6NcYNjH3mzB/1AZNDQ/cnomOXvL2yBzjVLhl+pMa2AGP2LMcOfcWp7sJsD7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZHbC8aI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7250844b0ecso2868229b3a.1;
        Tue, 26 Nov 2024 16:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732667712; x=1733272512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwEHHjeePOFS8sifKhXNpJZ8wSDgwVbUUuXuwR9Q1ZM=;
        b=FZHbC8aIYCryoOUFjEqIWpXFUXfMAeROiari77/ePPd+ZUP/cTlzihAwbqW8eA/Es6
         npcl3MwxK44uHghbw/ZhqqvEEzt7DUZ5G9ltmEh3bkpunoieSigjuxTnNJkNMRVJYO/c
         FIJW6qEOo69OoHsvRsHA4MRskUo+nGefWNyY6znk+HUDwmP7whuMGvbeSEO19Uc/5Wts
         Kn0JtlZPlx+ZMj+7STOGU5gEiGU9ZOFfCRpHvRc2LytHAvF0tEhleG8DTn31fJeIR4k7
         2AMKyjWVgOteMPaAW+n7DpbQKzNBPUiiHEoUkKzPHYozACEHYhLRBP5SYuN1BxjryYnK
         MPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732667712; x=1733272512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwEHHjeePOFS8sifKhXNpJZ8wSDgwVbUUuXuwR9Q1ZM=;
        b=Rz8hXUTF3y0SIM7Xx9tcs2/czaZICMwA0WZdyismnhKgH+9jOcbmNfHt17awSmH1Av
         oiQILjvI11N8fqib0FG6iqxvRAVoVfCPJV1mcLUjxyenoRRycv8Z/frmtShMTaVvgdVw
         68pxHDzUv07x2P7hU/2oFwQ1wwZsB1SCvObormPVrjjyw/39E0tQdOw/TKIQnzxejT9B
         ur2xUcbERFeglJ5KP2dEXgPZETpuTUYsY1/8We92YCDY1OXn6lYZ2OZQjR99Wy6BbyQE
         rb8tUkZte2kWaMce7/e2wjfjWJ0c33wta7OSkUS3zgeeVHzDsE0b6ZnnmftpNBRrQ/DB
         nxiA==
X-Forwarded-Encrypted: i=1; AJvYcCUAAsoprjH7Yb0FfC0WEbnYkC4XCAe4HB5UP5cqVvEON0qTiZ7i2i6/8T2h5OSvqZ1mWqQ=@vger.kernel.org, AJvYcCUSxPNJsttHQIPFL2ojJfZ7OOoP6QxnWyenEloicvUaqzHksgYGGdgL9c4IUrPgsaH5hXU6WCNMXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/lKqvSWuFfkVLqDNl9CBKJQo01epW76S7zOA7Kqn761i0UlNr
	Ch1ZOyC/Q+5JKKgAsT02K3STbwGORU5Xy7unwXXgTxt0RpJa9d/X
X-Gm-Gg: ASbGnctlYIUCOFlsOCawhcl3bzRuXAke74d9ae7VH0sRUsO5UIZL4jZBVOgtSKmci1w
	4A1+TONCtPhlTWaVUkSzQABtR2G3eNnNcsS89xT+ee170L2IJOfPE/kMfp8HnxrwsEmVwCH2qTY
	DpBi1xU9XjnUhVszfjIQMrMmb5srS3t9xRZ21T8+0q6Ek3/CDiF/PH3RGGH+1/jAKel8ynae5e9
	eJB034ItFq7he+QSDcObfN6d8FsZQcneE6HlPNaLbL6xAM=
X-Google-Smtp-Source: AGHT+IHD1XuN8URbcGc6l2ZUECnAebfDlrucXcXvHYpCgKIL6IvV6a9BgOMV68Tu5uvyT0d+4xPENA==
X-Received: by 2002:a17:90b:5483:b0:2ea:5823:c13d with SMTP id 98e67ed59e1d1-2ee08ecf50emr1603912a91.18.1732667712058;
        Tue, 26 Nov 2024 16:35:12 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa33374sm175760a91.4.2024.11.26.16.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 16:35:11 -0800 (PST)
Message-ID: <ba62f39bf3670008a6e1a2af114b14dd7fdc1c96.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/1] btf_encoder: handle .BTF_ids section
 endianness
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org, 
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
 ast@kernel.org, 	daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, Alan Maguire	 <alan.maguire@oracle.com>, Daniel Xu
 <dxu@dxuuu.xyz>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Vadim
 Fedorenko <vadfed@meta.com>, Vadim Fedorenko	 <vadim.fedorenko@linux.dev>
Date: Tue, 26 Nov 2024 16:35:06 -0800
In-Reply-To: <Z0YbQr_QTNrfNqAE@x1>
References: <20241122214431.292196-1-eddyz87@gmail.com>
	 <20241122214431.292196-2-eddyz87@gmail.com> <Z0HXqLswziDAjNrk@krava>
	 <Z0X2YnMyzNlZyQtP@x1>
	 <b2e5cb3b1478d6900f126d4de223500d6be4c97d.camel@gmail.com>
	 <Z0YbQr_QTNrfNqAE@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Arnaldo,

Please note a message [0] from Andrii,
where he suggests using elf_getdata_rawchunk() libelf function.
I tried it, it works, makes the patch much smaller.
I'll send a v3 shortly.

[0] https://lore.kernel.org/dwarves/8744c86ba355245f7ecc14d00351c82285fbf64=
4.camel@gmail.com/T/#me4c02e4a4e7fdd0e69dd52b2a6bf598966dc2145

Thanks,
Eduard


