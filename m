Return-Path: <bpf+bounces-9624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B447279A6A9
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1DD28112C
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83ABE7F;
	Mon, 11 Sep 2023 09:20:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC239BE5D
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 09:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0DCD5
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694424013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS9lli0wQxzaeTtYduf+SRNAVGdyjoOnuF5+YHmnsp0=;
	b=b2diDwa/IJETC9P9b4zXQE83FN42nBpTI0OzgtpL2WbwCMJl0bqPMJVwWL2cz6BwIYwvVX
	CSfb269cVgrbhAbpW/QG6TSgv3CWM64O9JGUNuQzhkoDDMMYWmpnRKBUov3UvE82pX7iw7
	7evdu3NsNMQoVweF032WxBZ55HCXD8s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-oPFERa_3N1G6Lk5DgYqYkA-1; Mon, 11 Sep 2023 05:20:10 -0400
X-MC-Unique: oPFERa_3N1G6Lk5DgYqYkA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9aa20a75780so83180166b.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424009; x=1695028809;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GS9lli0wQxzaeTtYduf+SRNAVGdyjoOnuF5+YHmnsp0=;
        b=HEH5LWo5JHo7CmLXW61dgT1XzXOSPaU9iZwtklrjtlT1b/b4nS62e1SU68ulPLbzi9
         MiZHl19S9eYA/Zz4ickb5sEDRvIbT5z2fDe1NHQt7l5SIkarFzVWTxYrqPD5QATl96Q1
         Lr/6VicM3PiyELuonal3tN14J8guiRmWzuCPo+Y+LSlBI0Am+Iznbb60HJ4b02d+UtDC
         KQNv3CE1Fth3epxJmz9aSuZ2MiM8C0XhkN+WoYY81/UeuAOkuiiSo0w6uS0rUpuEMN6d
         wqWhbynkD9MO710S+MiAC3AZWpnjgcj+QVV3RmFv+WQh0G5JqetA80EIoQkJNFF76RRB
         Jg1w==
X-Gm-Message-State: AOJu0YyrYxjhjTslLIsyrqSgNTr9kflLsTXt0LCgMvgBUzlWy64zzBkn
	ViNHor9XLWC77q6EGKhBChsIJHAfqqkS08u8+0DBtYE2dP8t9aF/hxyQulcljEpyduDUyZVWhMQ
	Jr0kI54qhjrFI
X-Received: by 2002:a17:906:768f:b0:9a0:9558:82a3 with SMTP id o15-20020a170906768f00b009a0955882a3mr6795803ejm.58.1694424009394;
        Mon, 11 Sep 2023 02:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkBc0rdiHwYVxnqaCimatHdHg4I0Z4S/Rok+rT3zSfqZu/ml0H/GPLrSjgEsNYr1vPJUl/Ug==
X-Received: by 2002:a17:906:768f:b0:9a0:9558:82a3 with SMTP id o15-20020a170906768f00b009a0955882a3mr6795791ejm.58.1694424009051;
        Mon, 11 Sep 2023 02:20:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906360700b0098ce63e36e9sm5135636ejb.16.2023.09.11.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:20:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1D72EDC709D; Mon, 11 Sep 2023 11:20:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: Tree wide: Replace xdp_do_flush_map()
 with xdp_do_flush().
In-Reply-To: <20230908143215.869913-2-bigeasy@linutronix.de>
References: <20230908143215.869913-1-bigeasy@linutronix.de>
 <20230908143215.869913-2-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Sep 2023 11:20:08 +0200
Message-ID: <87pm2pkqwn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> xdp_do_flush_map() is deprecated and new code should use xdp_do_flush()
> instead.
>
> Replace xdp_do_flush_map() with xdp_do_flush().
>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arthur Kiyanovski <akiyano@amazon.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> Cc: David Arinzon <darinzon@amazon.com>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Felix Fietkau <nbd@nbd.name>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Louis Peens <louis.peens@corigine.com>
> Cc: Marcin Wojtas <mw@semihalf.com>
> Cc: Mark Lee <Mark-MC.Lee@mediatek.com>
> Cc: Martin Habets <habetsm.xilinx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Noam Dagan <ndagan@amazon.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Saeed Bishara <saeedb@amazon.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Shay Agroskin <shayagr@amazon.com>
> Cc: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you for doing this cleanup!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


