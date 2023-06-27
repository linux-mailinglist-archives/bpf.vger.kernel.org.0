Return-Path: <bpf+bounces-3568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50773FDC3
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567D81C20A5B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1B18C1B;
	Tue, 27 Jun 2023 14:25:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677E16429
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:25:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635EC2D67
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687875932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
	b=Ffkb9gxXPxDnb4vbueLitz3YRK6AHWv2HOdGAhLNL65ry16uHvjIy9hVVgd6hD0JasnVSG
	IbC7bcvDIeQ/lN39NJh7+yfDhF9pfu0KY9FDsscqxKePNsDbnJCsX2q4sx33fdIL+mPBse
	+TrbmiO46JHEW7/fdgdQEaEeWnIRcLw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-0cnMr0h4PJ-Qbi-cBaGZsg-1; Tue, 27 Jun 2023 10:25:28 -0400
X-MC-Unique: 0cnMr0h4PJ-Qbi-cBaGZsg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98e40d91fdfso248288866b.3
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 07:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875915; x=1690467915;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGSc4mdTDNNjtXngrQkAE2Vk0OODhwWQe551QFWP1tI=;
        b=XH1LSw7zYBag5JbtltNGNjskaF5cH6VlDRheKjBQjk2VP3aRTFNsVu2dIns9Vy3vgm
         bY63/jH3OpfIJguptPHzIDVJ0Y24c1LfM9sJSMDsRlIPnHZ1rjWXjtpdEZ2LOOi6Bxtg
         DxtK+bt2ODqotj9B0Pv4sx76Jg2xIubCiM+T818ZU4Z40IRiL1HaPCf471HxVY9nruE4
         jqvY5pE6cfVVk3tgbMBIlGrpHJcsMVDcQFRQPf0RFE/opCV+BAIw7dGx3JqzGG2p9g99
         kJpb7bE6DiJl5BriC7INUxExzCESvxFGu0imP4nGBF9toXv86yQAruAaWLoveGgekeMo
         n91A==
X-Gm-Message-State: AC+VfDw8tV9cissTAE3eJpBFcuZtpfpNuRsvqPZFcJMeT00Ma4uFmYVW
	JE4nnDJcMZIwKPK5OHPD7IGQZ53q7A0a5x1LoFkzoCV513u6noc1qNNq4rEJxmCHlxVH7A7aquQ
	Q839EbefxtviT
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188636ejb.60.1687875914698;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6i5PkNbA3Uw3V9yHzNgEF6zgc+6XvzXai4Ju+na594EFjrV8ZjoKAuLT8tuRH4vcpCqG3Dfw==
X-Received: by 2002:a17:906:da8b:b0:982:26c5:6525 with SMTP id xh11-20020a170906da8b00b0098226c56525mr32188620ejb.60.1687875914199;
        Tue, 27 Jun 2023 07:25:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qn1-20020a170907210100b0098e42bef731sm3234766ejb.169.2023.06.27.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:25:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2921ABBFF6C; Tue, 27 Jun 2023 16:25:13 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 coreteam@netfilter.org, netfilter-devel@vger.kernel.org, fw@strlen.de,
 daniel@iogearbox.net
Cc: dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <cover.1687819413.git.dxu@dxuuu.xyz>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 27 Jun 2023 16:25:13 +0200
Message-ID: <874jmthtiu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> The basic idea is we bump a refcnt on the netfilter defrag module and
> then run the bpf prog after the defrag module runs. This allows bpf
> progs to transparently see full, reassembled packets. The nice thing
> about this is that progs don't have to carry around logic to detect
> fragments.

One high-level comment after glancing through the series: Instead of
allocating a flag specifically for the defrag module, why not support
loading (and holding) arbitrary netfilter modules in the UAPI? If we
need to allocate a new flag every time someone wants to use a netfilter
module along with BPF we'll run out of flags pretty quickly :)

-Toke


