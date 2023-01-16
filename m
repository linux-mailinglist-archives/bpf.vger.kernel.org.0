Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36A466CCCB
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 18:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjAPR3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 12:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjAPR2x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 12:28:53 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB304EC5;
        Mon, 16 Jan 2023 09:06:24 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSw9-000Puw-P7; Mon, 16 Jan 2023 18:06:21 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSw9-0002xa-Ch; Mon, 16 Jan 2023 18:06:21 +0100
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Eric Curtin <ecurtin@redhat.com>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
Date:   Mon, 16 Jan 2023 18:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26783/Mon Jan 16 09:28:30 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/16/23 5:52 PM, Miguel Ojeda wrote:
> On Mon, Jan 16, 2023 at 5:37 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> I presume Miguel will pick this up via rust tree? (Either way, would be nice to
>> also get an Ack from Arnaldo.)
> 
> I am happy to, but I think it would be great if BPF takes it whenever
> you think it is a good time. And indeed, let's give time to Arnaldo to
> take a look.

Ok, if you could ack it for the rust bits, we can route it via bpf-next.

Thanks,
Daniel
