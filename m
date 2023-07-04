Return-Path: <bpf+bounces-3948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D06746D03
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86661C20923
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD05256;
	Tue,  4 Jul 2023 09:16:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420746A2;
	Tue,  4 Jul 2023 09:16:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DECB3;
	Tue,  4 Jul 2023 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V3G3llqyqDYpZVEogHvFY85hMe7xLSqrYXDqBNV0Ifs=; b=YOEZTrYis9yeXxQwXE2+AuiBuP
	nsYIAeD+Z5uLOr8jOdbUCC12XGdcCNWm0bhk2TXTByQbEsVpeyiIp2HkrbB1AaQonEc38tfAQWXE2
	zqtUJqOwxb2ec0nkn34x41V/qyiYJecWXcOGW6HbSdy0mtvNqk63x0kdVbnGMQ20vuiXh3rYLwEpf
	5UoO5w52Pd5CEV0FtZLLnr4rwqF0MM+xxDvqAyvvYutxjdP2vrLl+DtLC+adgECInJPD9SndYT/cZ
	1UtUDwI7kZkLydcOHTepdLLDwZk24wWCaQq4fJLOvCv1pt+YzH3YS8GUhZknh0pNiVH4vyaUOwNtv
	9ZC+lZMw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGc8o-000MaJ-Oi; Tue, 04 Jul 2023 11:16:10 +0200
Received: from [81.6.34.132] (helo=localhost.localdomain)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGc8o-0003b8-5f; Tue, 04 Jul 2023 11:16:10 +0200
Subject: Re: [PATCH bpf-next] xsk: honor SO_BINDTODEVICE on bind
To: Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230703175329.3259672-1-i.maximets@ovn.org>
 <CACGkMEs1WyKwSuE2H0bkYigjhqHYJy6pPGnQLjWgOFt9+89hJA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <94b00e51-aaac-5e7c-d447-f45af408e389@iogearbox.net>
Date: Tue, 4 Jul 2023 11:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs1WyKwSuE2H0bkYigjhqHYJy6pPGnQLjWgOFt9+89hJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26959/Tue Jul  4 09:29:23 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/4/23 4:31 AM, Jason Wang wrote:
> On Tue, Jul 4, 2023 at 1:53 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
>> A privileged process might create the socket and pass it to a
>> non-privileged process for later use.  However, that process will be
>> able to bind the socket to any network interface.  Even though it will
>> not be able to receive any traffic without modification of the BPF map,
>> the situation is not ideal.
>>
>> Sockets already have a mechanism that can be used to restrict what
>> interface they can be attached to.  That is SO_BINDTODEVICE.
>>
>> To change the SO_BINDTODEVICE binding the process will need CAP_NET_RAW.
>>
>> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
>> workflow when non-privileged process is using AF_XDP.
>>
>> The intended workflow is following:
>>
>>    1. First process creates a bare socket with socket(AF_XDP, ...).
>>    2. First process loads the XSK program to the interface.
>>    3. First process adds the socket fd to a BPF map.
>>    4. First process ties socket fd to a particular interface using
>>       SO_BINDTODEVICE.
>>    5. First process sends socket fd to a second process.
>>    6. Second process allocates UMEM.
>>    7. Second process binds socket to the interface with bind(...).
>>    8. Second process sends/receives the traffic.
>>
>> All the steps above are possible today if the first process is
>> privileged and the second one has sufficient RLIMIT_MEMLOCK and no
>> capabilities.  However, the second process will be able to bind the
>> socket to any interface it wants on step 7 and send traffic from it.
>> With the proposed change, the second process will be able to bind
>> the socket only to a specific interface chosen by the first process
>> at step 4.
>>
>> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Is this a stable material or not?

To me this is a bug rather than 'feature', so I applied it to bpf tree and
also added Fixes tag. Thanks everyone!

