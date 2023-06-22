Return-Path: <bpf+bounces-3107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9273965A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B147D281841
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 04:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787621FC6;
	Thu, 22 Jun 2023 04:22:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7381C02
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 04:22:06 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F61BE3;
	Wed, 21 Jun 2023 21:21:54 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-311394406d0so4220831f8f.2;
        Wed, 21 Jun 2023 21:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687407713; x=1689999713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ECnfbr1yMldiaqGJ4AwBQXH8Qu2uEGTBBXNGiQr9KY=;
        b=JdM4u+HlPkJEwG2PTTdNk6gkZLEAipSkMuxkwuy29Nswu7Rv6kci/ZauLKY5zfJoye
         F2sDO0PLowady/RMAVVpVdh/7lJ5Z2W+d7N4xJ6zyt9zd8S3dGvzrehGAWNVr6ATYJKg
         c5Fbbcs5IFsGpQr7gnERMMjwunT3Q3+V6IXwvbb4Igf6IyTSVLTi5npSDK8ZU/796eOD
         8dFfe0zPPP34IqOG86+nn7chj5/Tvhsy/00jGSw6CMv/lqEX49Rjn2QqHcBwR1ZiGMGe
         TCkCuP9xP7zKWHk/u23csS43ipN2qov8LqhWcIy5DaU00mmQHo1KH/AF7SvvLK2sUJDn
         W9yQ==
X-Gm-Message-State: AC+VfDzl+QuYSxQQ+2TgzOp5M1c576ipciyMyO+wRvhKvjU32phktY1D
	A72Xtc9Jy0QYfc4VwnXf8VY=
X-Google-Smtp-Source: ACHHUZ6noBUR8iTvT8VR1EETx/SJbcA6a56KL+Jlcz/+OUxvfjHqkrQVqSA29+PLsepDYKMNhlEycQ==
X-Received: by 2002:a05:6000:10ce:b0:312:9eb6:33da with SMTP id b14-20020a05600010ce00b003129eb633damr17577wrx.20.1687407712404;
        Wed, 21 Jun 2023 21:21:52 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d604a000000b0031272fced4dsm5942680wrt.52.2023.06.21.21.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 21:21:51 -0700 (PDT)
Message-ID: <fc37eccc-b9b3-d888-6b57-78cd61986a11@kernel.org>
Date: Thu, 22 Jun 2023 06:21:48 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/11] sysctl: Add size to register_sysctl_init
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Benjamin LaHaise <bcrl@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
 Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 Eric Biederman <ebiederm@xmission.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Amir Goldstein <amir73il@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, John Ogness <john.ogness@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Mark Rutland <mark.rutland@arm.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, kexec@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091037eucas1p188e11d8064526a5a0549217d5a419647@eucas1p1.samsung.com>
 <20230621091000.424843-9-j.granados@samsung.com>
 <2023062150-outbound-quiet-2609@gregkh>
 <20230621131552.pqsordxcjmiopciq@localhost>
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230621131552.pqsordxcjmiopciq@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21. 06. 23, 15:15, Joel Granados wrote:
> On Wed, Jun 21, 2023 at 12:47:58PM +0200, Greg Kroah-Hartman wrote:
>> On Wed, Jun 21, 2023 at 11:09:57AM +0200, Joel Granados wrote:
>>>   static int __init random_sysctls_init(void)
>>>   {
>>> -	register_sysctl_init("kernel/random", random_table);
>>> +	register_sysctl_init("kernel/random", random_table,
>>> +			     ARRAY_SIZE(random_table));
>>
>> As mentioned before, why not just do:
>>
>> #define register_sysctl_init(string, table)	\
>> 	__register_sysctl_init(string, table, ARRAY_SIZE(table);
> Answered you in the original mail where you suggested it.

I am curious what that was, do you have a link?

-- 
js
suse labs


