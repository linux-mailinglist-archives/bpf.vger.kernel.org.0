Return-Path: <bpf+bounces-2774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F54733D3D
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 02:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96121C210B9
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F1652;
	Sat, 17 Jun 2023 00:39:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09332371
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 00:39:30 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD013A9E
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:39:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so211955b3a.1
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686962369; x=1689554369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsMGQiXPrgtK7axETFl+C7ri5S5PdMa9vY2bfrwgSfw=;
        b=J68FTuubnmA+oYsVTdotui6LRVVLyx+Zy8ykqM0c7LFWEEXCWqmIbUHPAhelXrJzwv
         Oy09gSB86TmLcFYumksr9kyId9SuBrJq45Vv65Ywj+21A+FKnBnic2CmX9iyYrUvHOeF
         wvSpqzjfW+YgrqQ9QkQAmKD2eXeIIwRBxIqWmoFw5T4Ii/sv/Ik+OqdeDIaj0WFVPltV
         LO8SUnm3NCO/2B/WAddJzY6kW2Afvs1nw8pygt+XQBwfQd4v/kR4dNyXieYNWP2Rmuxy
         laQx+iBsVvrzm+V6pzKWqI63fJjxDO3lY4HG/1k5CmFO6H6AadNhrZcqV3A6y5IRLtOV
         7XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686962369; x=1689554369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsMGQiXPrgtK7axETFl+C7ri5S5PdMa9vY2bfrwgSfw=;
        b=PdQgFjur9ELFDluXQOOJFL86VLw2kSp5oeYTfCwQnQ8cfMlD3BCr2igQreWIXi785M
         TkB2fkuiqMJ+mTqa4782DbuU2naOeZYmvGZ5hvpZtANS+Ul/t6+MXcM+Ih55sewGPCBP
         XYUibbYRiN8PHICDGvoNGARUX1OxOB1WozhrRLjcRO6oDToJX/SCwphXDSD1ZKFaBYLf
         i1nPTGZkXcCfLnB8JGOT/3r9miR5dpX4txT8QhGHhnih/yDNlM8fmY4Lh1as37quaKgS
         vReMpzC5+1jYupYRXchbhPZX+z6ytJd0HdheBVIiihkxQf/10e5/HuFu/7ZlA/v1p+uz
         +vzw==
X-Gm-Message-State: AC+VfDzim3QFA+bmd7pCsMBw9y+fnxEdR2GcDvRNUXDRWu+P+264weQj
	AQVvghEabmILdlfU5oGJUzo=
X-Google-Smtp-Source: ACHHUZ6gLpygqlIVRtayWdSU2S7N1pdIJj6hf+03VgB1165NO3RWdysZ7Lt7BJAsTv+gzETlvXZehw==
X-Received: by 2002:a05:6a21:7886:b0:10f:1f0:9b43 with SMTP id bf6-20020a056a21788600b0010f01f09b43mr4950297pzc.6.1686962368897;
        Fri, 16 Jun 2023 17:39:28 -0700 (PDT)
Received: from MacBook-Pro-8.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:39f3])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b006468222af91sm13973541pfa.48.2023.06.16.17.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 17:39:28 -0700 (PDT)
Date: Fri, 16 Jun 2023 17:39:25 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, quentin@isovalent.com, jolsa@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 0/9] bpf: support BTF kind layout info, CRCs
Message-ID: <20230617003925.hrzvkiyasj4rwhdj@MacBook-Pro-8.local.dhcp.thefacebook.com>
References: <20230616171728.530116-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616171728.530116-1-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 06:17:18PM +0100, Alan Maguire wrote:
> By separating parsing BTF from using all the information
> it provides, we allow BTF to encode new features even if
> they cannot be used.  This is helpful in particular for
> cases where newer tools for BTF generation run on an
> older kernel; BTF kinds may be present that the kernel
> cannot yet use, but at least it can parse the BTF
> provided.  Meanwhile userspace tools with newer libbpf
> may be able to use the newer information.

Overall looks great, but
why such narrow formatting? It's much less than 80.

> 
> The intent is to support encoding of kind layouts
> optionally so that tools like pahole can add this
> information.  So for each kind we record
> 
> - kind-related flags
> - length of singular element following struct btf_type
> - length of each of the btf_vlen() elements following
> 
> In addition we make space in the BTF header for
> CRC32s computed over the BTF along with a CRC for
> the base BTF; this allows split BTF to identify
> a mismatch explicitly.
> 
> The ideas here were discussed at [1], with further
> discussion at [2].
> 
> Future work can take more advantage of these features
> such as
> 
> - using base CRC to identify base/module BTF mismatch
>   explicitly
> - using absence of a base BTF CRC as evidence that
>   BTF is standalone

That's fine to have as a follow up, but with BTF_FLAG_CRC_SET
the kernel should check the crc.
Calling crc32c on modern cpus should be plenty fast.
It won't slow down btf verification.

