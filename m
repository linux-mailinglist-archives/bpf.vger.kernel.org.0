Return-Path: <bpf+bounces-8070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED2B780E92
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E630E1C21653
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF418C22;
	Fri, 18 Aug 2023 15:06:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF62374
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:06:46 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6067AF7
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A/KGSOLlFM3RdcgifSC247nCfT6YsYA68bUMMXHTdLU=; b=BHfy4LCfPnmsXRZjJEHDsuRThG
	uG1sczdTgiQJLmP70NSYpn3Y3wb34JF/9DbtL3o7LgLOj1KPNc4Tsu2Jg4XG9gzpNIYDTzpHH0M+0
	O5Ecjbk/gPTvabb1NEG6jQEStcV+CGWjf0iCtDWIoVjc+Bt8nVrl8DteQlN3DXZCk0BZq1ZUQvV8O
	/moZ6FVxds9CTJu0fmCNkTIJb8c2npmcUaJohvAhG4/ap+WtgnKzibtDFyolbjSyNDeK4OXkl5SDt
	eKIoQZON+WROwVK/dUEkiw+3MbbhZqvtc2kWCCVDR5lj+Bb/nc3RH/AAk6vz2eNxOKIxrFZ7uYfcs
	m5Z2zrrQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX13e-000Hi9-81; Fri, 18 Aug 2023 17:06:37 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qX13d-000P8N-Gu; Fri, 18 Aug 2023 17:06:37 +0200
Subject: Re: [bpf-next PATCH v1] samples/bpf: Cleanup repetitive swap function
To: Anh Tuan Phan <tuananhlfc@gmail.com>, sdf@google.com, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20230817154615.87967-1-tuananhlfc@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d740be32-d6a3-b07d-8fad-0e252f18df7d@iogearbox.net>
Date: Fri, 18 Aug 2023 17:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230817154615.87967-1-tuananhlfc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27004/Fri Aug 18 09:41:49 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 5:46 PM, Anh Tuan Phan wrote:
> Use the macro version of swap function and move its definition to
> bpf_util.h since it is repetitive in some files. This commit also fixes
> a warning from coccinelle:
> 
> - ./samples/bpf/xdp_sample_user.c:1493:8-9: WARNING opportunity for swap()
> - ./samples/bpf/xdp_rxq_info_user.c:435:8-9: WARNING opportunity for swap()
> 
> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>

I don't think it really improves anything. If a user takes this sample, he/she
now needs to figure out that the swap implementation is actually somewhere hidden
deep in tools/testing/selftests/bpf/bpf_util.h to ensure/audit that there's nothing
special about it.

Thanks,
Daniel

