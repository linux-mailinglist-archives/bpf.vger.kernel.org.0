Return-Path: <bpf+bounces-11105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B387B2F85
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 11:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A1EBA284AD5
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90B154B0;
	Fri, 29 Sep 2023 09:45:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EE1428E
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 09:45:47 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF26CF1
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 02:45:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso141904585e9.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1695980743; x=1696585543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJ0GANRa7sUcJbj27/1+KenBMSJ+y4OklCLaMq3ZW8=;
        b=dEktDTLhgbfjE6nKHPTsC5KXAX9EPiWmMT7mcXw5yURwvon2ZpCpHAQbN1VcZXr2vz
         oLsLA2Ie0yIah+LHVwP2CHaLmEJU7QDz/La66GXkxX1ZgWo7+Wegfj79AamDysQ6DfQS
         33QuXkThOH8MSEYbqtlcKx8JGbFblc9CQdmwglXrCzJCXD6dS9jAQ8d0yFIXusqNtZqh
         OJkTyZ0mVCLBhzLRrABHw/ecokpD29vr08nHZaDrt/5eZ6PNNtADH45hc6qoxofnjk1F
         4379H+YqBWdYNQpTLDAjuCuOOXCIBNVQ4SZsp+5GwesOc4L+c6b2JPwHB0vo8E+R7wuz
         4FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695980743; x=1696585543;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRJ0GANRa7sUcJbj27/1+KenBMSJ+y4OklCLaMq3ZW8=;
        b=p7zkZSUKM7feG+2xsEf8yaEseE+oxmzHXYEZ1t9e13K90Qk+i1bUqpVMOOA9YNVDig
         I1vcDmJkms6TymEBxI5amql935oLxOOcuuw+AHnXxvz8zi8J8YzJgdj3CFdbLDrWbaKq
         IaMO8+ig9Iyhe6QYBcz6dxGRuRDmIz622/rhylI1vW5klNiuy0zWXemcYIgWmS01Q+ka
         MlSEim2MElBIgeC+98/xgaJwTNkFHFhK3jvhB5qDJRPgCK1BLm8JXLdyTcflL0vV3UJ2
         2kk2Ttxu6AVw2HXkbSBqCHKKoAXmJkwx5/DY7DBvLfrQzJ3bqn+WrJczFdm4KL3wg7CV
         V2Ew==
X-Gm-Message-State: AOJu0YzoAkZAORWLTC3pfjtVgp8hxGhbMXwSo7m8B15gzAWBwulkDGOY
	6ApLTuL8PfqDnAhtP7ICCjN97A==
X-Google-Smtp-Source: AGHT+IHWENDYDABrt98f6WZ+Sh1rcyikYIE9aK1cO9ig4MR/P5VqnqmvXS8T/+x+MCJZayvvLPJnOQ==
X-Received: by 2002:a05:600c:2146:b0:402:ea96:c09a with SMTP id v6-20020a05600c214600b00402ea96c09amr3454604wml.16.1695980743251;
        Fri, 29 Sep 2023 02:45:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:a470:6c6:a6ee:941f? ([2a01:e0a:b41:c160:a470:6c6:a6ee:941f])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc445000000b003fbe791a0e8sm1080036wmi.0.2023.09.29.02.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 02:45:42 -0700 (PDT)
Message-ID: <0a70d4fb-b790-cd7f-a0cd-ad38e978b0e9@6wind.com>
Date: Fri, 29 Sep 2023 11:45:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Persisting mounts between 'ip netns' invocations
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>, David Ahern <dsahern@kernel.org>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
 <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
 <87il7ucg5z.fsf@toke.dk> <a68b135f-12ee-3c75-8b12-d039c9036d53@6wind.com>
 <20230929-paket-pechschwarz-a259da786431@brauner>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230929-paket-pechschwarz-a259da786431@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 29/09/2023 à 11:25, Christian Brauner a écrit :
>> I fear that creating a new mount ns for each net ns will introduce more problems.
> 
> Not sure if we're talking past each other but that is what's happening
> now. Each new ip netns exec invocation will allocate a _new_ mount
> namespace. In other words, if you have 300 ip netns exec commands
> running then there will be 300 individual mount namespaces active.
> 
> What I tried to say is that ip netns exec could be changed to
> _optionally_ allocate a prepared mount namespace that is shared between
> ip netns exec commands. And yeah, that would need to be a new command
> line addition to ip netns exec.

Ok, you talked about changing 'ip netns exec', not adding an option, thus I
thought that you suggested adding this unconditionally ;-)

I was asking myself how to propagate mount points between the parent and 'ip
netns exec' (both way), but this may be another use case than Toke's use case.


Regards,
Nicolas

