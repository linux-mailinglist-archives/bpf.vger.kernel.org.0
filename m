Return-Path: <bpf+bounces-13650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7527DC419
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8EB20E4D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA7ECD;
	Tue, 31 Oct 2023 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJfONlx6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF1A54
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:02:54 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73359E8
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:02:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso34216055ad.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698717772; x=1699322572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1DZxw4m3W15KAXThmhdlySviXDWXIdp0IL06WBFzExc=;
        b=dJfONlx6v6y6amlBj8Dy/ZaAMwVRfmKKxZBGYjq+Z9oUhWRoXdulBvoz/uThUVRMTa
         NIG0WFDhENOh5nj1v8aaRFeftXuolxOakq/DdvBWNft8/HSwm+Lzpn0LFU8ZYmNa1aPf
         VAquq1iH3LPBgqS/bjSWqWPu07LauAFYfnLpM6KBRzaYsahR2dSM90KUozrUSy/+SnQS
         xoH2ksBSulBMck7YzjXzKR8G7H2egMx1tv6wmr4lOz9LfvWMWN3zEuDgFXNg27nj+0fy
         RfvcoDnUeOAxZ7FVZVFT17RqWHbNcCaxpAobkpa/RL+yW7LegzGoKI8STMZ+V5I0/N75
         xkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717772; x=1699322572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DZxw4m3W15KAXThmhdlySviXDWXIdp0IL06WBFzExc=;
        b=oUoUVBYUW88QfUVDZ41DlFUWDj2lSTx/eaNtqpdjdPHAVimNW8OQU/zfT5QUVG1vMK
         FceDntd3U8ajpt9TkwxMTDQq9IpVJK++jp9vpRjO84VYIgBbCsRTWJa4SzaeMSWwc1QP
         ds1ardm/AtMOC3jOWyLNwFYmP2vPqdW+7XGpTmFK3qXlSwvMFop8wUe4CYIbVsKLUDo5
         C1D/oFVv6ZL21d/hFUPyH1770x8GpRC95yTt01kLqdvk4kTVdqoniqfLseQnEbebMZp/
         Aq+OrRKqllQhzcgIAhF7bLQ6LcLy5FXFmMUX6ZXNsqgkdyQreaMdz5gR0zJoCD0LmDtc
         w5Pg==
X-Gm-Message-State: AOJu0YxRgSLiX6gIi3VhTHVcPHBgqWFWMTNgVjwCg5f4igsGyA460NE4
	MqW17hXom44OkX/tiL1O/n4=
X-Google-Smtp-Source: AGHT+IEYdcEmDVb3X4Rf4W/b7obKKw4P8dcFnPYl980I6WfjhkJ/kW0KYc+QBekGcPxOxReeMSo88A==
X-Received: by 2002:a17:903:244f:b0:1cc:4205:88ce with SMTP id l15-20020a170903244f00b001cc420588cemr7227239pls.46.1698717771434;
        Mon, 30 Oct 2023 19:02:51 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:e78a])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001c444f185b4sm151429plg.237.2023.10.30.19.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:02:51 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:02:48 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
Message-ID: <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231027181346.4019398-18-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-18-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:40AM -0700, Andrii Nakryiko wrote:
>  static void reg_set_min_max(struct bpf_reg_state *true_reg1,
> +			    struct bpf_reg_state *true_reg2,
>  			    struct bpf_reg_state *false_reg1,
> -			    u64 val, u32 val32,
> +			    struct bpf_reg_state *false_reg2,
>  			    u8 opcode, bool is_jmp32)
>  {
> -	struct tnum false_32off = tnum_subreg(false_reg1->var_off);
> -	struct tnum false_64off = false_reg1->var_off;
> -	struct tnum true_32off = tnum_subreg(true_reg1->var_off);
> -	struct tnum true_64off = true_reg1->var_off;
> -	s64 sval = (s64)val;
> -	s32 sval32 = (s32)val32;
> -
> -	/* If the dst_reg is a pointer, we can't learn anything about its
> -	 * variable offset from the compare (unless src_reg were a pointer into
> -	 * the same object, but we don't bother with that.
> -	 * Since false_reg1 and true_reg1 have the same type by construction, we
> -	 * only need to check one of them for pointerness.
> +	struct tnum false_32off, false_64off;
> +	struct tnum true_32off, true_64off;
> +	u64 val;
> +	u32 val32;
> +	s64 sval;
> +	s32 sval32;
> +
> +	/* If either register is a pointer, we can't learn anything about its
> +	 * variable offset from the compare (unless they were a pointer into
> +	 * the same object, but we don't bother with that).
>  	 */
> -	if (__is_pointer_value(false, false_reg1))

The removal of the above check, but not the comment was surprising and concerning,
so I did a bit of git-archaeology.
It was added in commit f1174f77b50c ("bpf/verifier: rework value tracking")
back in 2017 !
and in that commit reg_set_min_max() was always called with reg == scalar.
It looked like premature check. Then I spotted a comment in that commit:
  * this is only legit if both are scalars (or pointers to the same
  * object, I suppose, but we don't support that right now), because
  * otherwise the different base pointers mean the offsets aren't
  * comparable.
so the intent back then was to generalize reg_set_min_max() to be used with pointers too,
but we never got around to do that and the comment now reads:
  * this is only legit if both are scalars (or pointers to the same
  * object, I suppose, see the PTR_MAYBE_NULL related if block below),
  * because otherwise the different base pointers mean the offsets aren't
  * comparable.

So please remove is_pointer check and remove the comment,
and fixup the comment in check_cond_jmp_op() where reg_set_min_max().

