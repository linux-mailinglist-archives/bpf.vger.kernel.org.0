Return-Path: <bpf+bounces-59500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2B7ACC658
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30043188CF13
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F0B23027C;
	Tue,  3 Jun 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+wVuJtY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364222FDFF;
	Tue,  3 Jun 2025 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953172; cv=none; b=TBLdv3d5fsXd4/uaJfmTa0phlJyP8YF2WPanPyGMtL1x2UAymQHYoVTD2FMH/xbaujRfpwrktDX638tijwMOxxW548msHi9VoiCUT8tIRXcwBmOx/Bh0wKE/zBA0bc3vOsHpFuoh1xvpAn3PRVgLiIza853GIg3p0vAUMIU6yQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953172; c=relaxed/simple;
	bh=KmfCVtAmKd+c6F2iLh67WUf7iv3096BupaXDLmHV+ic=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce6ihSGARJ2zl7QrmhXSyqc55mRsbMVVto/aXpP3smiprmCk4vAcKjXrtSVs47KrazReWxRwoCHZJq6s13IHfsl5FSYg59rw6plrGmb7A8/FirEFUb9P4xdeosXfZybfomCq6Ac1E6WNi4kq808vj/uAvMulhs2qmuvJz/PtivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+wVuJtY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d54214adso21852055e9.3;
        Tue, 03 Jun 2025 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748953169; x=1749557969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xuMreV0Rn7o2M9XPK0srZFbdJwKYNHfW070OhzRV3U=;
        b=B+wVuJtYiMAIac8H8m3Src9TreW4cgBcwkf5oe6muhKFjRSy91QxisppWMiap2ydN2
         ykBt76enKdtCsexefEOCEq6/aXD6zl5uehWvu06u4LCdpxIWLpkL6IZxxwxdLb6S3sn6
         RQB7ktVdUSDrtsKOrKuQbHNtS09wMMaWv8eZIFCogRHZCucdp9HpXghlVjGjb08TmAPt
         YXDLfKyxhLnQDIOjHS1htEtXk9RWdHZx8ySNQAsUI7g1hpzH4KWz8GYxfcC8sdmqjSHm
         JbwHOgJGa5mxztrTGF4zm0FmEsJLsG1TymoZfEqaDrp9L5Ghcc6E9DtW3pUWqsQ+OxpK
         9M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748953169; x=1749557969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xuMreV0Rn7o2M9XPK0srZFbdJwKYNHfW070OhzRV3U=;
        b=WHSkGcd7cMwua1chCmJKwkz3s3fu/hnO/4qToJrL0xqiJh7MQa67QWBmUNiCrxuCY0
         7u3ydFvJ6F9rE85p1Gybz4QJOa9BkGWxKMHmRalfQxab8sUkO9JxR72PIe6kH2Y/z662
         rWQCEfoxY6wXGNJ9GDc3ZtNzZ2DSCc3rHg+sAMmuUp8vJP4AeDkDnFoRLpymi+jTWdYc
         r75lxeR4HO5R2wH5Sbu8UlRAVLCiEIdYVVAD8JaqGAonCWCK4aek/sIEiN8XcJY1rQgh
         gZFsatYTuHdGWIKbaaTYUAR+evvYVc9skg9b9DFRXaPgAVAvusen1T+QVBDSfRO1S+ID
         O29Q==
X-Forwarded-Encrypted: i=1; AJvYcCUy9KFGAyJNmQQjxNfIZpKbjvSrJ3y0cXQUeF3dvNup8tTQTEnSBJhGYiBl0cquzbr7omg=@vger.kernel.org, AJvYcCXOFJUSuIJ+5xVjkUa2cpdGF9f5nF1oGQNty/o/EuUU7tlqsutoFy/1oH6OgWD9Ux6KfqELTHjTGfXnwYJ4@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN1Fz2knyQGPnBZ/XmH7D7phQs+yvnjQ2KttZzwfgx7kXD1So
	afpvRVKBd8cfnvbvio4VtCdwXhX2BuhtgxKThmpzDs/A2lA96FcfQ66l
X-Gm-Gg: ASbGncssr1zOni7xEFp750G3NAoGYav/pVjEpBZTM77vz6fEJD0D+l1yoeOPZyxeuki
	jerhyf3tYMqFzH148y82CqstGEOSEzoQaOEFX2Ub/bMnPzoJED/P5dD0K1er3PcF+K5VHEv2yjE
	6eIdnpBWCeNSqXxHDJEGpJEOx1ljh+qUSLKIleMy+y1fwg8FvogdLm2unaOCWqqj0F+zOmlWhd0
	vKaBtNcz+gnFCfkIVMDYgqk7Zx3cZe0AVIM4fqHqjRhkCBz9ECsptiondVe8QSvtchX2kPkysCu
	e8PGOTAYTSG5GnRzSZ0KnOfqWR+1Lrn7tamwM1Xy1GknDyYrOZL/TTJuSDY0
X-Google-Smtp-Source: AGHT+IGx/z4GtoM0DY2RzlVw2RyNURaw584EmIm8Tsn6VaSO9U+fEhjn36ws1gQq1v0MVEEeL5gVgw==
X-Received: by 2002:adf:f34a:0:b0:3a4:f8e9:cee0 with SMTP id ffacd0b85a97d-3a4f8e9cf5cmr10683428f8f.40.1748953168830;
        Tue, 03 Jun 2025 05:19:28 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm18409985f8f.69.2025.06.03.05.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 05:19:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 3 Jun 2025 14:19:26 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, qmo@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add cookies check for
 raw_tp fill_link_info test
Message-ID: <aD7oTouJgXoOru_g@krava>
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
 <20250603022610.3005963-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603022610.3005963-2-chen.dylane@linux.dev>

On Tue, Jun 03, 2025 at 10:26:09AM +0800, Tao Chen wrote:
> Adding tests for getting cookie with fill_link_info for raw_tp.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     | 26 ++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 6befa87043..0774ae6c1b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -635,10 +635,29 @@ static void tp_btf_subtest(struct test_bpf_cookie *skel)
>  	bpf_link__destroy(link);
>  }
>  
> +static int verify_raw_tp_link_info(int fd, u64 cookie)
> +{
> +	struct bpf_link_info info;
> +	int err;
> +	u32 len = sizeof(info);
> +
> +	memset(&info, 0, sizeof(info));
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	if (!ASSERT_OK(err, "get_link_info"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_RAW_TRACEPOINT, "link_type"))
> +		return -1;
> +
> +	ASSERT_EQ(info.raw_tracepoint.cookie, cookie, "raw_tp_cookie");
> +
> +	return 0;
> +}
> +
>  static void raw_tp_subtest(struct test_bpf_cookie *skel)
>  {
>  	__u64 cookie;
> -	int prog_fd, link_fd = -1;
> +	int err, prog_fd, link_fd = -1;
>  	struct bpf_link *link = NULL;
>  	LIBBPF_OPTS(bpf_raw_tp_opts, raw_tp_opts);
>  	LIBBPF_OPTS(bpf_raw_tracepoint_opts, opts);
> @@ -656,6 +675,11 @@ static void raw_tp_subtest(struct test_bpf_cookie *skel)
>  		goto cleanup;
>  
>  	usleep(1); /* trigger */
> +
> +	err = verify_raw_tp_link_info(link_fd, cookie);
> +	if (!ASSERT_OK(err, "verify_raw_tp_link_info"))
> +		goto cleanup;
> +
>  	close(link_fd); /* detach */
>  	link_fd = -1;
>  
> -- 
> 2.43.0
> 
> 

