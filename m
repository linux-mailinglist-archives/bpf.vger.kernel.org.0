Return-Path: <bpf+bounces-7879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CC477DB0D
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEFF2817B9
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A53CC8E4;
	Wed, 16 Aug 2023 07:22:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FF17F7
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 07:22:31 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D5211E
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 00:22:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso58523585e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wowsignal-io.20221208.gappssmtp.com; s=20221208; t=1692170547; x=1692775347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3vDeZ9sAL2XfqwLLHhYqTBuGA7XemTxu1Dgf9vMBANY=;
        b=YNwFh/CZl6Y1aAsyLaExSWO4SaEaI/1hZPtdvbGJKXOur3CBIL3mIxhQ1kyR7gNz0/
         dMJh+OztB//yFRThq2cR4xX/m62X8N+ucK9phdVQTUj0ISWbcQuCHm0OW92CiIw/imsf
         5RQyOiRZm3uFJarWzBJ3cCtYL8PNMtRv6XP1thhnytVzAUT5g4j26++Lkqa9mTOI2juo
         yeVfnwOFsu85qJVhEdafUNnRTNPgyRDxiMNpdDW01QVrFlw9W4tPyzlg3dEJYXQ5rfaC
         i/jWfgNb8jEt7yVENyIo60Gjp47wQpLtoHjzs2NdQVL+Sl97Dy2T5CMbDcgqry+tozyt
         GUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170547; x=1692775347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vDeZ9sAL2XfqwLLHhYqTBuGA7XemTxu1Dgf9vMBANY=;
        b=WL6ny2KfU/wXUD214W5+v32I9IjlH8mJxD6U3bexCgtH54Ry//ARHeIUIhcjOqMrDM
         olna+0xxQYuODN5xRxdYWCpSDYtMrd4sQCpffDDScGe6THpzX5+pSGcPLnphVpD69ygC
         d79iHtQ1aRXny36/6KmH5tfwDMnkT76ryu9AfWc+DMcLfMeIAzfjV1hd6eY0JTgUTtLX
         6Fx+kcUIZGqzAM3IME/IIfW09S/6jIahcuBDZzHS2BsLfosPNFHZCD4Y0ba7WahQgejC
         WwYnxHR06TPOOaa00zMLL2qQaUHseghPl5g+eOk3AmUE1RrCbAIZQ5v7D9lBIpwqP0zs
         g7jQ==
X-Gm-Message-State: AOJu0Ywm45cUahXW+WEQTLDp3MaZ4tpywkUklAnbXsdnCWjMid7wpOSK
	z1FEE1gKl9e/wEye6QTArQlLkw==
X-Google-Smtp-Source: AGHT+IGy6kFbupZaNOki9+UOmwg+uZxOM6PYn7UJ1AdKLKltOEBk8YpBMGzAzKAavALkAC1UmtD3XQ==
X-Received: by 2002:a7b:c5c8:0:b0:3fd:2d42:9392 with SMTP id n8-20020a7bc5c8000000b003fd2d429392mr683551wmk.4.1692170546837;
        Wed, 16 Aug 2023 00:22:26 -0700 (PDT)
Received: from localhost (212-51-140-210.fiber7.init7.net. [212.51.140.210])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b003fbdd5d0758sm20091816wmk.22.2023.08.16.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 00:22:26 -0700 (PDT)
Date: Wed, 16 Aug 2023 09:22:25 +0200
From: Adam Sindelar <adam@wowsignal.io>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Adam Sindelar <ats@fb.com>,
	David Vernet <void@manifault.com>,
	Brendan Jackman <jackmanb@google.com>,
	KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v5] libbpf: Expose API to consume one ring at a
 time
Message-ID: <ZNx5Meh0doxdXs4H@Momo.fritz.box>
References: <20230728093346.673994-1-adam@wowsignal.io>
 <7c792532-4474-b523-08f9-f82fb57f1b09@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c792532-4474-b523-08f9-f82fb57f1b09@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:51:25PM +0800, Hou Tao wrote:
> 
Hi, sorry for potentially dumb question, but should I do anything else
after someone acks it? This is a minor patch for a userland component,
but it's really helpful IMO - is anything preventing this getting merged
at this point?

Thanks,
Adam

> On 7/28/2023 5:33 PM, Adam Sindelar wrote:
> > We already provide ring_buffer__epoll_fd to enable use of external
> > polling systems. However, the only API available to consume the ring
> > buffer is ring_buffer__consume, which always checks all rings. When
> > polling for many events, this can be wasteful.
> >
> > Signed-off-by: Adam Sindelar <adam@wowsignal.io>
> 
> Acked-by: Hou Tao <houtao1@huawei.com>
> 

