Return-Path: <bpf+bounces-10390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7DC7A68C2
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07A02816C3
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646F38DF0;
	Tue, 19 Sep 2023 16:22:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B88813
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:22:15 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784B92
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:22:14 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59ea6064e2eso23869797b3.2
        for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695140533; x=1695745333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q0TPU34dMpePdJop08ByWvOSkZChuXAmj8qbmDpK4f8=;
        b=QSJW0vrutDwfHGth9lSj+vJjv+MOMbhi2VOZ6sMfSAnsAOhPntD9zxGcEMQvEzBGaj
         2pvwqSNkX4dNbOKslhnx5/Aft+Jj1Gr484f4K0GB2/tMWWGzlavqAHZiTLnBcKZgOjPo
         YpTgU6rtI/Wl7W0Xhu8r/YPKek7EGdrMpo7wcqzogbCzRKz8EwmJTDC9sFNTa3TdMigc
         PA+ceYv8aiBA+XddhyDcYWY/EKS5as9qjxRzGJShryQD0yHWBK8RHnICVo1MSnd93WFh
         DBehaVpGJlvCDvYNG3TAif36AwuJBnrWtSFXjyhwfkmlUIdGs59ONp27k4gAV5EkkFR9
         QLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140533; x=1695745333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0TPU34dMpePdJop08ByWvOSkZChuXAmj8qbmDpK4f8=;
        b=TGZQWyKg3zEPXPka1FrRGKZiP9r5qvyPcF5Qz9yTSUB0VcQJySgUN2YyAkS3Tnop8B
         wXmN/SoMc9DfIxVyOPSmNX4+AYeWTeZxLMZhjvDQ3LZqOujEXTmh6OTdOOyACCQyzfgG
         DiVXEnmWeu5BL0NKIHw2ZVzVVbuDayTlxbJyfH9rIQZ/kjw5D/rf4v8PQMbBCa7D3omk
         lmP/iH3U58PCzTKXmroPgAIUaoMbsB/gRZKanJc8lH9d9G2IsW4UdjJeiXQaodDz1vly
         T9fQApKBV3s6n3dAhjMpPhbcShJkTwErWjJP4qWuyN3wkOMhIoPVPbpcRA3/hkf9Jt2l
         Ez7w==
X-Gm-Message-State: AOJu0Yy66v+WxhXZmiqYa6wayBx7ECukqixiWYtbgCd2TUJBTIpzjfrm
	4crmChT9Us4pmJCqgXP8wvfQ8Q87KyI=
X-Google-Smtp-Source: AGHT+IFkmI673os5MrAHDpSm2eu6mbSk5oG2RMXFL8+1cfGzmKNeONx3AjkL0b96dPKw/ApkZ+rJyA==
X-Received: by 2002:a81:a104:0:b0:595:406b:93fa with SMTP id y4-20020a81a104000000b00595406b93famr14230435ywg.2.1695140533405;
        Tue, 19 Sep 2023 09:22:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b0e:1e45:8c20:a337? ([2600:1700:6cf8:1240:9b0e:1e45:8c20:a337])
        by smtp.gmail.com with ESMTPSA id er7-20020a05690c2d8700b0059c2e3b7d88sm2330602ywb.12.2023.09.19.09.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 09:22:12 -0700 (PDT)
Message-ID: <be0d14e6-072c-83a5-b21b-2ab33e97e3fa@gmail.com>
Date: Tue, 19 Sep 2023 09:22:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Is is possible to get the function calling stack in an fentry bpf
 program?
To: =?UTF-8?B?5YiY55WF?= <chang-liu22@mails.tsinghua.edu.cn>,
 bpf@vger.kernel.org
References: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <49b9b6f.1279.18aadb90e05.Coremail.chang-liu22@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/19/23 06:55, 刘畅 wrote:
> Hi all
> 
> I attached an fentry eBPF program to a kernel function, i.e., tcp_transmit_skb(). I want to implement different logic in the bpf program for different calling stack cases, e.g., __tcp_retransmit_skb()->tcp_transmit_skb() and tcp_write_xmit()->tcp_transmit_skb(). I know that I can access stack traces using the bpf_get_stack() helper function. However, in the fentry eBPF program, I don't know the value of the RSP and RBP register, which means I can not locate the return address even if I can get the stack traces. I want to know if there's any way that I can get the return address and thus get the function calling stack in an fentry bpf program.
> 
> I'd be appreciate if you can help me.
> 
> Chang Liu
> Tsinghua University, China

Once you get stack returned by bpf_get_stack(), it is an array of
addresses. For example,

  __u64 buf[256];
  bpf_get_stack(ctx, buf, 256, 0);

buf[0], buf[1], ... will be addresses of caller sites from most inner.

