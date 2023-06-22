Return-Path: <bpf+bounces-3181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57973A8C1
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25481C21185
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1D21064;
	Thu, 22 Jun 2023 19:02:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C31F923;
	Thu, 22 Jun 2023 19:02:25 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A491FF2;
	Thu, 22 Jun 2023 12:02:23 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-763c997ee0aso203651685a.3;
        Thu, 22 Jun 2023 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687460543; x=1690052543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUKVqpAkvwcAkqRbgPqSJCnjEmHwpCRiTBM6V9Wl0JI=;
        b=NFMjkIPQ8n5THqXlJ3GBdHE9pkALJhyaCi25q3wcypdND5JeqRRgBH+hLOalXh2zHo
         pIp1kOG3fM2Q9MDgAPqQAtVGHvOOjlJTOL8TJa55415jsSjFgkjJo2WkV7UDpoeoh3je
         9ZJ6Kyw1ljjo/req3uf37Bk9sAw2MEqtMKvCpje0rIrzXUWQQFuBtmeeC78Ccp3Q5/jw
         zwzVPI7Z2cArK+KdK9PZpFQ45G2sjmPUuwqmdgvcOe3R07+fVyNED0lygxzegm8D9eFu
         z7XOKZtQrX4JZoXg/BubrG5uo68ORY9f/RJpsLufL03AZLIDMsS/APOfS0IIhtLwyBpo
         T2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460543; x=1690052543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUKVqpAkvwcAkqRbgPqSJCnjEmHwpCRiTBM6V9Wl0JI=;
        b=OYr7TMqaim5B7yIVIYgMTJRS7Re2ZIBwOLmGBfQhtaKSSbvZbYZhKKphzGmhYR7TqV
         MCT0gxLUt9MGsjIkOzHBs0qq/rBfZX2qQx/eVGk4TuEZ7P90hBQzyNvQCYAthqx5QwXv
         52VxAon/xzKh704Xy6iv5MUwY/5Yr6rCWXkT7qGgGVYxwfQAzP9zX6NReyKgHodVI1Wx
         w0aEttP/mp+Sv757nYamNJsjMFGLAxG/xw9IV5lsqtb8/S19/Pvv1wq5fXHDr/45g0lg
         av2+tddQAYWh4pBSTMVhOdF+w3+mxt0KnD0ba59lHIlou8SpRt8GyyBzrPz5iWyx8FdE
         lN5w==
X-Gm-Message-State: AC+VfDyoos+kvi44L13w7FCHZq+dWf09oulQvJR8BEdcd6FI+S576K7v
	XkOTPMjji03xlOZckgVrBzx8DdoJwTlxfs4g
X-Google-Smtp-Source: ACHHUZ5CoD5bFfxw3o+JrwBisUgD4pIRoMw0clbbU+tXPVo0sEN48tKJ8OQ+/roTw9WcJG2RXowD5g==
X-Received: by 2002:a05:620a:6846:b0:75d:54fc:47b1 with SMTP id ru6-20020a05620a684600b0075d54fc47b1mr22804244qkn.54.1687460542955;
        Thu, 22 Jun 2023 12:02:22 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id p6-20020a0cf546000000b00623819de804sm4115104qvm.127.2023.06.22.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:02:22 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:02:21 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, bjorn@kernel.org,
	tirthendu.sarkar@intel.com, simon.horman@corigine.com,
	toke@kernel.org
Subject: Re: [PATCH v4 bpf-next 01/22] xsk: prepare 'options' in xdp_desc for
 multi-buffer use
Message-ID: <ZJSavRFNNvSvoATt@d3>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
 <20230615172606.349557-2-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615172606.349557-2-maciej.fijalkowski@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-06-15 19:25 +0200, Maciej Fijalkowski wrote:
> From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> 
> Use the 'options' field in xdp_desc as a packet continuity marker. Since
> 'options' field was unused till now and was expected to be set to 0, the
> 'eop' descriptor will have it set to 0, while the non-eop descriptors
> will have to set it to 1. This ensures legacy applications continue to
> work without needing any change for single-buffer packets.
> 
> Add helper functions and extend xskq_prod_reserve_desc() to use the
> 'options' field.
> 
> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> ---
>  include/uapi/linux/if_xdp.h |  7 +++++++
>  net/xdp/xsk.c               |  8 ++++----
>  net/xdp/xsk_queue.h         | 12 +++++++++---
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
[...]
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 6d40a77fccbe..ad81b19e6fdf 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -130,6 +130,11 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
>  	return false;
>  }
>  
> +static inline bool xp_unused_options_set(u16 options)
                                            ^
To match struct xdp_desc, this should be u32, no?

