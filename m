Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524369BA56
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBROCz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBROCy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 09:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2461423F
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676728925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRzLO+tA/rMKWELgzSE4vwEgVXv8YBCOYe+f1LqKzkY=;
        b=YivCEOABO+IXF6JRIknfH99UYW7X1ve5PTPPfZAEl4DCwJUj5eUiOqX1TyFAPYBX+J/XMQ
        /fUq+4UeHjMT76xaBDmCquHnPgGe9ABxTU5KSsiVhE6K9JPouQGkNXS+XOyAo8rVDAOnpY
        g7JxOPZO/3qMAQck7JjRXjJiLEp3its=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-J7t1pbrDNxqTX_7yWkk4yQ-1; Sat, 18 Feb 2023 09:02:00 -0500
X-MC-Unique: J7t1pbrDNxqTX_7yWkk4yQ-1
Received: by mail-ed1-f72.google.com with SMTP id i26-20020aa7c9da000000b004acc4f8aa3fso1065666edt.3
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 06:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRzLO+tA/rMKWELgzSE4vwEgVXv8YBCOYe+f1LqKzkY=;
        b=SSdf23t7/QvkQipc7EkGBwf8nNKKAK/VQFZjxAH+LOeH2v7+gpshXPBJNSEZyBMR0z
         QYd0hG3t0LitgGuyg78IkSEPl87ZHjrkCUcUJl/uYI8jKB7BPX0CJJOHS8Iop4/IvZqQ
         r1whT+AevIWhVLKY7MQQXfN/2tMd5hpG2MN4GQE1l3KCMn1JcSWpifrASYDwVD1TYEyX
         aCZXUlTPoc3AsqoClzx/khG5uZSiuri7uWHZv7avtuvYut+Nr3yh/Tvk0ZSh1eXFNTfS
         cdGewEPI7ukP7ZJpbECHm5stGnZqx0I5FZRsR+wAfQclSQlrJEkduoTohGqe+9WqvCKM
         LD7w==
X-Gm-Message-State: AO0yUKUS9kKIhdYd2/642F+CPoZNgRzK43E+0UU0Ots08yTiVTGiDQ5P
        9lG24DN2queG1PmYDNA8KxqFrJLcQIhK0I9tFXEyLf4VNiSXEE9j52EWpf1cNGWoHiHtsOWDIy2
        5Qu5Y40YdSizl
X-Received: by 2002:a05:6402:1101:b0:4ab:2423:e310 with SMTP id u1-20020a056402110100b004ab2423e310mr559532edv.28.1676728919527;
        Sat, 18 Feb 2023 06:01:59 -0800 (PST)
X-Google-Smtp-Source: AK7set9PYXjrsok6ngp3XrR7xLUnp336tLH9uDj5zEdDkekt+6s1HRybMlhmpjAG0Vj9ISGSKBlTlg==
X-Received: by 2002:a05:6402:1101:b0:4ab:2423:e310 with SMTP id u1-20020a056402110100b004ab2423e310mr559518edv.28.1676728919271;
        Sat, 18 Feb 2023 06:01:59 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id t9-20020a50d709000000b004a249a97d84sm3602514edi.23.2023.02.18.06.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 06:01:58 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <df48ff0b-d96b-7231-1b3d-02509a574c9b@redhat.com>
Date:   Sat, 18 Feb 2023 15:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH bpf-next V2] xdp: bpf_xdp_metadata use
 NODEV for no device support
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
References: <167663589722.1933643.15760680115820248363.stgit@firesoul>
 <Y++6IvP+PloUrCxs@google.com>
 <514bb57b-cc3e-7b7e-c7d4-94cdf52565d6@linux.dev>
 <CAKH8qBujK0RnOHi3EH_KwKamEtQRYJ6izoYRBB2_2CQias0HXA@mail.gmail.com>
 <eed53c45-84c4-9978-5323-cede57d9d797@linux.dev>
 <CAKH8qBvwPA_VaHfwqzPN4SNFqCTgVFWH9zMj0LXio_=8Dg3TOw@mail.gmail.com>
 <87mt5cow4w.fsf@toke.dk>
In-Reply-To: <87mt5cow4w.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 17/02/2023 21.49, Toke Høiland-Jørgensen wrote:
> Stanislav Fomichev <sdf@google.com> writes:
> 
>> On Fri, Feb 17, 2023 at 9:55 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 2/17/23 9:40 AM, Stanislav Fomichev wrote:
>>>> On Fri, Feb 17, 2023 at 9:39 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>
>>>>> On 2/17/23 9:32 AM, Stanislav Fomichev wrote:
>>>>>> On 02/17, Jesper Dangaard Brouer wrote:
>>>>>>> With our XDP-hints kfunc approach, where individual drivers overload the
>>>>>>> default implementation, it can be hard for API users to determine
>>>>>>> whether or not the current device driver have this kfunc available.
>>>>>>
>>>>>>> Change the default implementations to use an errno (ENODEV), that
>>>>>>> drivers shouldn't return, to make it possible for BPF runtime to
>>>>>>> determine if bpf kfunc for xdp metadata isn't implemented by driver.
>>>>>>
>>>>>>> This is intended to ease supporting and troubleshooting setups. E.g.
>>>>>>> when users on mailing list report -19 (ENODEV) as an error, then we can
>>>>>>> immediately tell them their device driver is too old.
>>>>>>
>>>>>> I agree with the v1 comments that I'm not sure how it helps.
>>>>>> Why can't we update the doc in the same fashion and say that
>>>>>> the drivers shouldn't return EOPNOTSUPP?

Okay, lets go in this direction then.
I will update the drivers to not return EOPNOTSUPP.

What should drivers then return instead.
I will propose that driver return ENODATA instead?

--Jesper

