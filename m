Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029F5B3172
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiIIIMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiIIIMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D8B6D61
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662711162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1aljE3uZPlufePUzO0o5QnlpqVItqq0OhrVapvAOQE=;
        b=hm9RgqHgogEgHYv2SAt0TPLvXWBs0AkyYmg8f5mJyTy7Co+k3dvC89NytjU+UJmI9PA9ki
        rePgFGugTHnSgzbuzS2dsKdSENtwXdibj7v87UVNXTRCUNUixpqhC/Rbr3WlyRfzT9/Vlz
        LAFQpG8BvkQLxjhT6xPeMeJBWF43Ryg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-4vZVbGgeNs-n-K8OWyPjDQ-1; Fri, 09 Sep 2022 04:12:41 -0400
X-MC-Unique: 4vZVbGgeNs-n-K8OWyPjDQ-1
Received: by mail-wm1-f69.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so231825wmq.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 01:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w1aljE3uZPlufePUzO0o5QnlpqVItqq0OhrVapvAOQE=;
        b=xztPgzbSxOQ0wnqa8mJV7byAtyRg58diBQgK5SGQauLPULgoEFIskASt21bzoMWkPB
         ANiQQV3rNMyajGi/zyQKPBfeJrEIP8vmYnxjI85XmPHJG7ZvpMs84qnckR8qAjsbqdHi
         QS6E+Z8tirX1Xyskc8AUN/r6LvZ2LJsor0uEYy5cw8C0kl2/gRbcOCs7VHzIln5rFXAn
         SAUxv71l+pNa9sxLIH83NXOvmNqr/BU9EFfDA3bMBjxidRo5wZu4C8khQsbHpR5pa8eH
         4nU4onXD5igCgwEUtpVAfP46oLAW9CXDJN3yIQRSeL6AuGgK89bKzeNh/OBTfrZu5N5v
         f9JQ==
X-Gm-Message-State: ACgBeo1ImNz73kXuTDM2e4lKVUoLOjBTdC44VCUW1DDMDMMSqt5pHWXf
        2Qmbs5VHTSGcS4sIFQHlsZLzTyqULsSCljuyFtdPh+djRXio1tJq9OYAd9yWYts/h2nRlY5FmuX
        GPMTzbpX1++78
X-Received: by 2002:a05:6000:178d:b0:226:ffe8:72df with SMTP id e13-20020a056000178d00b00226ffe872dfmr7007129wrg.496.1662711160072;
        Fri, 09 Sep 2022 01:12:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6GbqXE9LDoUcwdJx+L6WAX5Qhcp4f5VOTBbdcg+7QT8tyP64NbNXEg6EPqcjB/DNWdFfFwDA==
X-Received: by 2002:a05:6000:178d:b0:226:ffe8:72df with SMTP id e13-20020a056000178d00b00226ffe872dfmr7007109wrg.496.1662711159833;
        Fri, 09 Sep 2022 01:12:39 -0700 (PDT)
Received: from [192.168.0.4] ([78.17.187.218])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b003a5c244fc13sm6247863wmp.2.2022.09.09.01.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 01:12:39 -0700 (PDT)
Message-ID: <e1ab2141-03cc-f97c-3788-59923a029203@redhat.com>
Date:   Fri, 9 Sep 2022 09:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH RFCv2 bpf-next 17/18] xsk: AF_XDP xdp-hints support in
 desc options
Content-Language: en-US
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <166256558657.1434226.7390735974413846384.stgit@firesoul>
 <CAJ8uoz3UcC2tnMtG8W6a3HpCKgaYSzSCqowLFQVwCcsr+NKBOQ@mail.gmail.com>
 <b5f0d10d-2d4e-34d6-1e45-c206cb6f5d26@redhat.com>
 <9aab9ef1-446d-57ab-5789-afffe27801f4@redhat.com>
 <CAJ8uoz0CD18RUYU4SMsubB8fhv3uOwp6wi_uKsZSu_aOV5piaA@mail.gmail.com>
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <CAJ8uoz0CD18RUYU4SMsubB8fhv3uOwp6wi_uKsZSu_aOV5piaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

<snip>
>>>>
>>>> * Instead encode this information into each metadata entry in the
>>>> metadata area, in some way so that a flags field is not needed (-1
>>>> signifies not valid, or whatever happens to make sense). This has the
>>>> drawback that the user might have to look at a large number of entries
>>>> just to find out there is nothing valid to read. To alleviate this, it
>>>> could be combined with the next suggestion.
>>>>
>>>> * Dedicate one bit in the options field to indicate that there is at
>>>> least one valid metadata entry in the metadata area. This could be
>>>> combined with the two approaches above. However, depending on what
>>>> metadata you have enabled, this bit might be pointless. If some
>>>> metadata is always valid, then it serves no purpose. But it might if
>>>> all enabled metadata is rarely valid, e.g., if you get an Rx timestamp
>>>> on one packet out of one thousand.
>>>>
>>
>> I like this option better! Except that I have hoped to get 2 bits ;-)
> 
> I will give you two if you need it Jesper, no problem :-).
> 

Ok I will look at implementing and testing this and post an update.

Thanks folks

>> The performance advantage is that the AF_XDP descriptor bits will
>> already be cache-hot, and if it indicates no-metadata-hints the AF_XDP
>> application can avoid reading the metadata cache-line :-).
> 
> Agreed. I prefer if we can keep it simple and fast like this.
> 
<snip>

