Return-Path: <bpf+bounces-659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F702705368
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72EA1C20E78
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DA3111A;
	Tue, 16 May 2023 16:18:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE5634CF9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 16:18:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CB55BE
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684253879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTbzb7Ep8RynUGNflCJEtG2qlbhJbczpgr8r4KMw/zg=;
	b=KIhcMan/oHG1x39ew9KLk+UZDzpHAiwQGmPRXuyV493APf27BI1BUCKk1eFB745tQYguJB
	A0zebgPwCVgD+XGDDYRPXKJsOCQ4ElOmwEE0mqZxBDVX1hnkOJFUEBnVuHX3ljaTiJg8x8
	HrXLOvtbTNx/IzSO7SNuTUOM9+nWOVw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-9EyflpvOMb2wFt5UhreK0Q-1; Tue, 16 May 2023 12:17:58 -0400
X-MC-Unique: 9EyflpvOMb2wFt5UhreK0Q-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96625ceef6cso1131036266b.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 09:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684253876; x=1686845876;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTbzb7Ep8RynUGNflCJEtG2qlbhJbczpgr8r4KMw/zg=;
        b=V0LTU9A09th/97pk4t0jf89nRwIGPTKXzuF9UONzudM6Fuq0APz5lFG4By00VQljM2
         rRWSRgtbpstlF+g85NNzRiQNscVMvp26cxjSFCgn2bbmIqmCI3TF0LIEmgBqlC7kJHFS
         33/UG3BBwQuAMaoOzqLEuhmAlz46IYN86WRTOFwkZDnsNNpBbc40T66YDzLb9vrLw2F8
         NPMlIMV+S0rR4JcRMDPpFCBlRCCiXF48QeGJUCb6o/XxssuSiXMHJHvY3S+7Sg2LF8AD
         0L9x0hvSGTae9MBGfI0YUPJLUUeSh9J8fqHv+SfXKc6Zd5U5JAUeLQ/vkY5tPuXrXSer
         1zXA==
X-Gm-Message-State: AC+VfDzIvivWl45WaqflDzgref8PUFChVFILdB50fedsmLB1N8kKlYdG
	9b2gXr80IEo1fLz6Pxg+b6mR2XHp/OOQuGEQtoX+cJFTH9r65Go7Ba/TIaQjJCOicM8IK9jK/8Z
	913KVlbjKDYSy
X-Received: by 2002:a17:907:a4b:b0:958:514f:d88a with SMTP id be11-20020a1709070a4b00b00958514fd88amr31234500ejc.34.1684253876116;
        Tue, 16 May 2023 09:17:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5V2oSLqxxdSSdm1migvaEijLTSkJkHnpzZwu83PoVjaStqNRNRdE43yFnAIJq9NJklVz44Aw==
X-Received: by 2002:a17:907:a4b:b0:958:514f:d88a with SMTP id be11-20020a1709070a4b00b00958514fd88amr31234473ejc.34.1684253875788;
        Tue, 16 May 2023 09:17:55 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00960005e09a3sm11160343ejb.61.2023.05.16.09.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:17:55 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <47d535b9-a42a-3d5b-1ddd-8f58766e826b@redhat.com>
Date: Tue, 16 May 2023 18:17:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND bpf-next 06/15] ice: Support HW timestamp hint
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
References: <20230512152607.992209-1-larysa.zaremba@intel.com>
 <20230512152607.992209-7-larysa.zaremba@intel.com>
 <ZF6DHOtnr/AfYxML@google.com>
In-Reply-To: <ZF6DHOtnr/AfYxML@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 12/05/2023 20.19, Stanislav Fomichev wrote:
>> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> index 2515f5f7a2b6..e9589cadf811 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>> @@ -537,3 +537,25 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
>>   			spin_unlock(&xdp_ring->tx_lock);
>>   	}
>>   }
>> +
>> +/**
>> + * ice_xdp_rx_hw_ts - HW timestamp XDP hint handler
>> + * @ctx: XDP buff pointer
>> + * @ts_ns: destination address
>> + *
>> + * Copy HW timestamp (if available) to the destination address.
>> + */
>> +static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
>> +{
>> +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
>> +
>> +	if (!ice_ptp_copy_rx_hwts_from_desc(xdp_ext->rx_ring,
>> +					    xdp_ext->eop_desc, ts_ns))
>> +		return -EOPNOTSUPP;
> Per Jesper's recent update, should this be ENODATA?
> 

Yes, please :-)

https://git.kernel.org/torvalds/c/915efd8a446b ("xdp: bpf_xdp_metadata 
use EOPNOTSUPP for no driver support")

--Jesper


