Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417316E5FE0
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDRLb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 07:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDRLb0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 07:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A896E93
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681817433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2NZNcaQomO+NKqJjtar1Xw2NrVLmqvUkGrhPIreowuY=;
        b=iXVVYpFbERhSIPX0GBQyIIoLw7rspQN+C5RwCdhm6LuD0G7r+ndmSwHYC1Ec27x1ENvJ6T
        gHKQeGtzhhcYfK5Gd+FxhWwCyM54q0PB5toZCKMlTnH70HZWt7U6CY8ZM01nLDnSmyMrM6
        PKSwgzXqk8HvUbFGgObSkcY0BY+P+lQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-IUAD8iMSM0Ggm5PUrqsJqA-1; Tue, 18 Apr 2023 07:30:32 -0400
X-MC-Unique: IUAD8iMSM0Ggm5PUrqsJqA-1
Received: by mail-ej1-f71.google.com with SMTP id vb5-20020a170907d04500b0094f734c6a5dso2429564ejc.12
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 04:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681817431; x=1684409431;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NZNcaQomO+NKqJjtar1Xw2NrVLmqvUkGrhPIreowuY=;
        b=i8/TLO2lcNU4t6mQOHk5sPZEj7jn6N8xUwUuwOVlRda3Mtl2KG0p0Fg7s0H1RZajVa
         wjvrpRfcLgIne+9lBUSnQEvaXrX1V9mqUbDZCClNH78PGy2+tBI6DWJCR2nMwY8Z9uDb
         SjMpa5+H9bNYJh0xbTxCJViqY2bMg3LB57yGuSeFBAGZBtfggpnJuwfm6atgcahKwb6r
         vxzJ37mA/H8b8EUPJimXcy/4JdpVpDteRHdUxMUGywx5tUikS5M6IwnCkehb7PhvWI/s
         FLt59mj2V/1PfH34gKDf5qhTIQVyHo9lG+Yh2KaniQwf26frdFpPIWTegr2ZSWNifopc
         1WfQ==
X-Gm-Message-State: AAQBX9f1799le+ze3CZz1/97/igb6qBpPyf342bUIWGKN9IP8HXgDW7w
        k6cxvrsKYT1gUCLVRCTCEHF4YwXMAgxdF2TLsT7dXgGsN449dNcbNupqPopzmhulHWhdFdJP4RO
        +c6wSKaLKdnY9
X-Received: by 2002:a17:906:f843:b0:94e:aa8e:b56e with SMTP id ks3-20020a170906f84300b0094eaa8eb56emr9920090ejb.33.1681817431003;
        Tue, 18 Apr 2023 04:30:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350acIP+hvK0ByCevyOjLp2f/7rZYWRoDzXgAVCS6a3+YiQfrV/CAqZB6bAiO8cFkN23mV6I27Q==
X-Received: by 2002:a17:906:f843:b0:94e:aa8e:b56e with SMTP id ks3-20020a170906f84300b0094eaa8eb56emr9920058ejb.33.1681817430677;
        Tue, 18 Apr 2023 04:30:30 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id xd10-20020a170907078a00b0095328ce9c8bsm435698ejb.67.2023.04.18.04.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:30:30 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <231f26bf-4dc7-81ed-fd2d-91badb3af6b9@redhat.com>
Date:   Tue, 18 Apr 2023 13:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [xdp-hints] [PATCH bpf-next V1 3/5] igc: add XDP hints kfuncs for
 RX timestamp
Content-Language: en-US
To:     "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?= =?UTF-8?Q?sen?= 
        <toke@redhat.com>
References: <168174338054.593471.8312147519616671551.stgit@firesoul>
 <168174343801.593471.10686331901576935015.stgit@firesoul>
 <PH0PR11MB5830F70FAC28BDBDE63AF01DD89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5830F70FAC28BDBDE63AF01DD89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 18/04/2023 06.16, Song, Yoong Siang wrote:
> On Monday, April 17, 2023 10:57 PM, Jesper Dangaard Brouer<brouer@redhat.com>  wrote:
[...]
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 3a844cf5be3f..862768d5d134 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
[...]
>>
>> +static int igc_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp) {
>> +	const struct igc_xdp_buff *ctx = (void *)_ctx;
>> +
>> +	if (igc_test_staterr(ctx->rx_desc, IGC_RXDADV_STAT_TSIP)) {
>> +		*timestamp = ctx->rx_ts;
>> +
>> +		return 0;
>> +	}
>> +
>> +	return -ENODATA;
>> +}
>> +
>> +const struct xdp_metadata_ops igc_xdp_metadata_ops = {
> Since igc_xdp_metadata_ops is used in igc_main.c only, suggest to make it static.

I agree, and I acknowledge that you have already pointed this our
earier, but I forgot when I rebased the patches.  Same for 4/5.

--Jesper

