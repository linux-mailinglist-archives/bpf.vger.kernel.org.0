Return-Path: <bpf+bounces-75-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A047D6F7AC3
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313291C213C8
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 01:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6D1117;
	Fri,  5 May 2023 01:54:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1A7E
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 01:54:27 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276F12083
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 18:54:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaec6f189cso8299715ad.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683251666; x=1685843666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMizpcbuHrelx8QU8AtsSzHyvKg6nPVvQ33+1BxfBU=;
        b=PNuN57JuV69qcO2JI9vhB7wutSRYt3beeJ39hFDCM5fiI07KCsjD+tBfRoLyn2PNmC
         C1t+cRADfudvYh9pEYfQiysFeIW9Gcfn0ryV0HnqwP7XgeDZ+FB1+KWpXc4VCMs3jv+B
         Bny3Z6cNLh2oO9XvWwMKBnlgSpXnU08orUd6kKXKwrFg09tLEX5ry74eG/f5Bc458HIE
         M0a5JHM7IGuOp1lR7M0i28ZmRekh6kD7lVjofc5po9wFNG6kySjUN19OgC2BnCRD74sH
         xghCvhiDOhZf/BV4X881cwXtIVucCnS/9oSN/cES5hfKtIELhjJuoZPgXjCuBf46GZ5e
         lqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683251666; x=1685843666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbMizpcbuHrelx8QU8AtsSzHyvKg6nPVvQ33+1BxfBU=;
        b=lHy/ZgMn+hxWwoc5cR5ANnnD3Fj1HNnxmgl4IIjMSI32A5SD/M/7xInOWp/JmP+h+R
         yFBn1a75ZmXPMYjMGL8v9ioVvBX4QZCgcId+W0fFO9VvCFO90iTIsYMnCxe07e6CfMYv
         jGEzXE/u3whPuijcvevhJ0eHFFWGzRU6Tm2RyvxUiDH/imFUr3QhzvFI15EE9/wMUqgd
         RdPP3ID6ED4C9Y9eV0F0KrePuQIeLXDopUbMCEvoo989NV0whrYI9bEoe812lmReCqrv
         rVNulgayU5vrt1T6nVGAYWQ9Zw7MR7T29GviEYvwfDZHPMtVS8UipvBtFRRtrAJfaoWh
         148Q==
X-Gm-Message-State: AC+VfDzxnMXlnW0FrVumw6A9fjvUAFSrENEZZtBzhI+ZY5IJq7QkuSm3
	6Xl1CWbehoDfzg0/4goXFeQ=
X-Google-Smtp-Source: ACHHUZ4xBhTlilnEZyMJjrTzi35tFMmhaBvQw43ITG2NvCGgIfgC/xMG4PS/YlM7O2Tkz956sYEQoQ==
X-Received: by 2002:a17:902:7b87:b0:1aa:ff24:f8f0 with SMTP id w7-20020a1709027b8700b001aaff24f8f0mr4865149pll.4.1683251666088;
        Thu, 04 May 2023 18:54:26 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902779000b001aaec9c4f1esm269962pll.156.2023.05.04.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 18:54:25 -0700 (PDT)
Date: Thu, 4 May 2023 18:54:23 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: encapsulate precision
 backtracking bookkeeping
Message-ID: <20230505015423.3ph2xqrlftwcfgoe@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230505000908.1265044-1-andrii@kernel.org>
 <20230505000908.1265044-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505000908.1265044-4-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 05:09:01PM -0700, Andrii Nakryiko wrote:
> +struct backtrack_state {
> +	struct bpf_verifier_env *env;
> +	u32 frame;
> +	u32 bitcnt;
> +	u32 reg_masks[MAX_CALL_FRAMES];
> +	u64 stack_masks[MAX_CALL_FRAMES];
> +};
> +

> +static inline u32 bt_empty(struct backtrack_state *bt)
> +{
> +	u64 mask = 0;
> +	int i;
> +
> +	for (i = 0; i < MAX_CALL_FRAMES; i++)
> +		mask |= bt->reg_masks[i] | bt->stack_masks[i];
> +
> +	return mask == 0;
> +}
> +
...
> +static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 frame, u32 reg)
> +{
> +	if (bt->reg_masks[frame] & (1 << reg))
> +		return;
> +
> +	bt->reg_masks[frame] |= 1 << reg;
> +	bt->bitcnt++;
> +}

So you went with bitcnt and bt_empty ?
I'm confused. I thought we discussed it's one or another.
I have slight preference towards bt_empty() as above. fwiw.

