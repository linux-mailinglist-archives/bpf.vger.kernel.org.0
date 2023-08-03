Return-Path: <bpf+bounces-6892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950376F3AF
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 21:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22925282175
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE782593A;
	Thu,  3 Aug 2023 19:53:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7925178
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 19:53:02 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CB01BF
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 12:53:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d0e009433c4so1572423276.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691092380; x=1691697180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJSbwAdf5q0UDDa3eWnhLUBAoOrSa5wdyzrf+ym0NUk=;
        b=sYQaAaaCV47B+AqfVwFAjTWnZMXGfipnFOTX6VQi26F2w2OEHziboTYaPFBfi4OBbI
         3rDFEoqbdhbuJIXlmUESc0bGToZgIRIxQ8FWOvJ176PUNCPTBNy8pmImhdJJYgK9aYp/
         XIUDLYwcE/CbFA+SLrWhKOz+kSg6ZHf7sC5FiKmFhCGED/ZHZy4R28wTFHG3bCO+FlzJ
         x9oQ/0vqWwyJ+7RXR1S75KPTL6ELpnS8GXxWU+HCHxJuVr6cPu8MjUaFW0yfWsZawQGN
         H+RmA9i1WRoFbnWPK5i5nuxsi7GUlL94u78OLe93JTcwUJgIkG5bcZSZLmunhTTY3G0C
         3XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691092380; x=1691697180;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJSbwAdf5q0UDDa3eWnhLUBAoOrSa5wdyzrf+ym0NUk=;
        b=Lf0pg6OghylO4YN3w8gFiZdVhq0K8EKtapEWIVpU1kwp/odxm6i4LxmdJAsiCS5Bni
         2FOG2zFa9MwULp/BJKugDe0KhydEncxA9bQRCfDMg8IgqikZN8thRQlj5Glp3HD05nyC
         btt9AwCReLVBxH4xuamShG3Wk+GYdSpiwrx3ASyp6+OOnOcOr21UxaqYs/a5Gd3tRF2r
         sxSsawNpm6c5lTIP1V+AtKAm2eeg1Sho8Zg1DiC57y4vk1FM491e3rp9IIfkpFN6cOX3
         aKG5+wHS/gYuEo76k/u82gzgDmrxA9T01gbcATmglVTQBwWaw8uGLlxdqhGDHLImzbhL
         YWDA==
X-Gm-Message-State: ABy/qLbt1hU5EsYuu0IWnefuHeExyFwnAbfIdqAUgYgzDp4OO/PuLYYF
	KQEUNOLQ7/iXD56OB2TTEZA=
X-Google-Smtp-Source: APBJJlGRBNoloTi4glRE+ZTzP+BKvwSvjaV2sd+ssCLXUr01CQrltDsI934/OkSnmUMtLrdvVl2GNg==
X-Received: by 2002:a0d:d7c8:0:b0:583:aca2:c0f0 with SMTP id z191-20020a0dd7c8000000b00583aca2c0f0mr19760007ywd.10.1691092380685;
        Thu, 03 Aug 2023 12:53:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:c07f:1e98:63f3:8107? ([2600:1700:6cf8:1240:c07f:1e98:63f3:8107])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b00570599de9a5sm185282ywd.88.2023.08.03.12.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 12:53:00 -0700 (PDT)
Message-ID: <8820810d-572f-1e63-0b58-a496fe49b4f1@gmail.com>
Date: Thu, 3 Aug 2023 12:52:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bug report] selftests/bpf: Verify that the cgroup_skb filters
 receive expected packets.
To: Dan Carpenter <dan.carpenter@linaro.org>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org
References: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 00:27, Dan Carpenter wrote:
> Hello Kui-Feng Lee,
> 
> The patch 539c7e67aa4a: "selftests/bpf: Verify that the cgroup_skb
> filters receive expected packets." from Jun 23, 2023 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c:116 connect_client_server_v6()
> 	warn: unsigned 'addr.sin6_port' is never less than zero.
> 
> ./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
>      107 static int connect_client_server_v6(int client_fd, int listen_fd)
>      108 {
>      109         struct sockaddr_in6 addr = {
>      110                 .sin6_family = AF_INET6,
>      111                 .sin6_addr = IN6ADDR_LOOPBACK_INIT,
>      112         };
>      113         int err;
>      114
>      115         addr.sin6_port = htons(get_sock_port_v6(listen_fd));
> --> 116         if (addr.sin6_port < 0)
>                      ^^^^^^^^^^^^^^^^^^
> Impossible and also it doesn't make sense to compare network endian data
> with < 0.

Hi Dan,

Thank you for pointing it out. It should check the returned value
of get_sock_port_v6() before calling htons(). I will send a patch
to fix it asap.


> 
>      117                 return -1;
>      118
>      119         err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
>      120         if (err < 0) {
>      121                 perror("connect");
>      122                 return -1;
>      123         }
>      124
>      125         return 0;
>      126 }
> 
> regards,
> dan carpenter
> 

