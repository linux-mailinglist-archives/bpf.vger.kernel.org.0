Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE966403D4
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiLBJz1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 04:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiLBJzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 04:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646BCA7A9
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 01:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669974865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0aJyBJ5pA14fenx25kvzt6VogtkX8oCBQc7dpQax/I=;
        b=SIyq8CCfITW2jg35C3NStTqAF15hK8oThy3R1MG0U9Di+RIu1WSGnpyF7MlLvkbnN48E4f
        ev4+WodUaY3cYPLrzkjM5cvuyOa0GgRxxbW+e8SStlyAp60/olmdD89REv/dKLK09LfIai
        mrejgN8deTNkPD4qZnMdolb2fnx4mwU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-hjB6H7kVOCSc_Ijcqlvcmg-1; Fri, 02 Dec 2022 04:54:24 -0500
X-MC-Unique: hjB6H7kVOCSc_Ijcqlvcmg-1
Received: by mail-wr1-f70.google.com with SMTP id r17-20020adfb1d1000000b002421ae7fd46so945349wra.10
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 01:54:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0aJyBJ5pA14fenx25kvzt6VogtkX8oCBQc7dpQax/I=;
        b=rfibKU3mAfU1YmzhCdHh5O2f0WdugUvusqo1uu5EcMln4Xih1aLZoFg7APWdsp+BRK
         gvRylmYsZorDClisKbctTdARLTITZ8RElH+X+NIOcjXp6Np/ixHEX9CfDjRg3x6iwSEJ
         ZAWTIL20IcTRNqNy6LepkPhT4Xz4Io5Rs8fbzVTnLx7dnGCNOSOZOqhsJDBHe/E2asjo
         /D9FHJ433Pdoq6k8vkUssdLPIizYhptiqMvrLapl22FKsdk6OJINdfDTJ9wwpGQfAAFr
         5nZ7pDR8GpKuarhuwoJyrSV59OlNnlFP+E1NZLSRHIv8p3sn743LGqpJCz6wsJwrRK0E
         YBzQ==
X-Gm-Message-State: ANoB5pldCkEtrVPxAPs5lHWl5X3AlAa5Cq6Fi1KAdhzZ8uGLyPddkTAZ
        S5zuKU1FSnK7nfFf4G68jxHsl26AlMBdd2RyYSaTiYSlW6dN6IkNwMd4hrbTOmtaKZkaoNO80zY
        mJe9DSULlQB+i
X-Received: by 2002:a5d:6d47:0:b0:230:3652:205 with SMTP id k7-20020a5d6d47000000b0023036520205mr31082858wri.322.1669974862805;
        Fri, 02 Dec 2022 01:54:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4LLi1uitwBarAh4GKhzvBRHZY/KzlIK4u4CzijY+hwD6+971nsU5Jj2jm6GI5+pmm4gZ5Kiw==
X-Received: by 2002:a5d:6d47:0:b0:230:3652:205 with SMTP id k7-20020a5d6d47000000b0023036520205mr31082847wri.322.1669974862583;
        Fri, 02 Dec 2022 01:54:22 -0800 (PST)
Received: from [192.168.0.4] ([78.16.131.111])
        by smtp.gmail.com with ESMTPSA id n12-20020a1c720c000000b003c64c186206sm7685171wmc.16.2022.12.02.01.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 01:54:22 -0800 (PST)
Message-ID: <552ef30f-2331-52c3-b364-8171f42d86ff@redhat.com>
Date:   Fri, 2 Dec 2022 09:54:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v2 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com
References: <20221201151352.34810-1-mtahhan@redhat.com>
 <Y4ld1BsRrXaPtz0L@debian.me>
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <Y4ld1BsRrXaPtz0L@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/12/2022 02:07, Bagas Sanjaya wrote:
> On Thu, Dec 01, 2022 at 03:13:52PM +0000, mtahhan@redhat.com wrote:
>> +When these maps are created BPF programs are attached to them. The list of
>> +allowed programs is shown below:
> Automatically attached BPF programs?


I will rephrase to indicate that the user typically attaches the 
programs to the maps. and fix the rest of the comments in a respin.

Thanks.

>
> Also, "The allowed programs are:"
>
>> +.. note::
>> +	For more details of the socket callbacks that get replaced please see:
>> +
>> +	- TCP BPF functions: ``net/ipv4/tcp_bpf.c``
>> +	- UDP BPF functions: ``net/ipv4/udp_bpf.c``
> "... please see ``net/ipv4/tcp_bpf.c`` and ``net/ipv4/udp_bpf.c`` for
> TCP and UDP functions, respectively"
>
> Otherwise LGTM.
>

