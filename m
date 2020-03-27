Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD42B1958B6
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 15:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0ONz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 10:13:55 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:36115 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0ONz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 10:13:55 -0400
Received: by mail-io1-f45.google.com with SMTP id d15so9956650iog.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nkEIjhHw7BreV312qjwqtRSCW8oRCNMghGsYFXpYSrk=;
        b=uUPSlOGtB+Y8rqjvcpwEgIOXF/o1uFylB/1g2Dll2sPXhD62v7PBv0SUT9ufjY9BQN
         DsKSXjWbVSg21JSBebDMuq04TGjqK6G6isuAzPRe2FtKxSYkpr3Cw3KOHoh+tCmJGiQs
         4ftpamlYJQEKHDVkiBTr9jA/6ZvRC706GXv8/wi71aWsuphgaMYEIcx3FZsCeuZVtuUU
         fEjC6InAcZZZbauqnkeKFn3PBDdt8OZSXNW6f5BdDFFC7b2NLXaIYR9uabRXB5wm3u7Z
         opCQBe2ybd149mrDOB/m0IROLoR+97duR0k+L+AKkymlprG/qzwBnt89dg6q9wsPqVuF
         LrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nkEIjhHw7BreV312qjwqtRSCW8oRCNMghGsYFXpYSrk=;
        b=VnH/dfxkK/n8V2i/sCuaarhbpFCUqHyOGsuPecsYdTUlDnfWaEWYEjQzTzaTZw0foe
         EjvKZEvosuWd+AT4YLDQoJ8fBNIZ/I5BS2Ysl4/GV7Z2Dael2A7lGE9xAK97T9Fw/W3V
         IY93hlo5sTHAENDL25IpTYVBRRwGmz2Z828Ht44cS1E7EKgv+jqg7bNH6MbsxpLXMYD8
         lwPlfQ++gIxmbc4cw+mRHbwk7YxAuBmqa5cpr4WpmhZd9WsBpDFimH+Cm0CBItNzLzNL
         Q75yhTKIGfPEHujr8V+bQDhSZm+3GgVN6WBYR19Fcled0RubEo4mmdDjfNCYsuAGJEJ1
         pKkQ==
X-Gm-Message-State: ANhLgQ2I7kV+IBfbDnxMxVP2FtZ+zqrtESHmQSHNaEc8GiT+i1uNPoly
        /MwkxnjtmUN8DK2l2+JcNNFuPA==
X-Google-Smtp-Source: ADFU+vsudZFf1bqL70fQz0SnZN+wOgX+tXx8WvQSeha8JT3KaVKOhHPS3DbcjANnrAlDlRio1BPHoA==
X-Received: by 2002:a05:6602:243c:: with SMTP id g28mr12740654iob.19.1585318433262;
        Fri, 27 Mar 2020 07:13:53 -0700 (PDT)
Received: from [10.0.0.125] (23-233-27-60.cpe.pppoe.ca. [23.233.27.60])
        by smtp.googlemail.com with ESMTPSA id l25sm1919948ild.61.2020.03.27.07.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 07:13:52 -0700 (PDT)
Subject: Re: [PATCHv3 bpf-next 0/5] Add bpf_sk_assign eBPF helper
To:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        eric.dumazet@gmail.com, lmb@cloudflare.com, kafai@fb.com,
        Roman Mashak <mrv@mojatatu.com>
References: <20200327042556.11560-1-joe@wand.net.nz>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <9ee7da2e-3675-9bd2-e317-c86cfa284e85@mojatatu.com>
Date:   Fri, 27 Mar 2020 10:13:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327042556.11560-1-joe@wand.net.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-27 12:25 a.m., Joe Stringer wrote:
> Introduce a new helper that allows assigning a previously-found socket
> to the skb as the packet is received towards the stack, to cause the
> stack to guide the packet towards that socket subject to local routing
> configuration. The intention is to support TProxy use cases more
> directly from eBPF programs attached at TC ingress, to simplify and
> streamline Linux stack configuration in scale environments with Cilium.
> 
> Normally in ip{,6}_rcv_core(), the skb will be orphaned, dropping any
> existing socket reference associated with the skb. Existing tproxy
> implementations in netfilter get around this restriction by running the
> tproxy logic after ip_rcv_core() in the PREROUTING table. However, this
> is not an option for TC-based logic (including eBPF programs attached at
> TC ingress).
> 
> This series introduces the BPF helper bpf_sk_assign() to associate the
> socket with the skb on the ingress path as the packet is passed up the
> stack. The initial patch in the series simply takes a reference on the
> socket to ensure safety, but later patches relax this for listen
> sockets.
> 
> To ensure delivery to the relevant socket, we still consult the routing
> table, for full examples of how to configure see the tests in patch #5;
> the simplest form of the route would look like this:
> 
>    $ ip route add local default dev lo
> 

Trying to understand so if we can port our tc action (and upstream),
we would need to replicate:

  bpf_sk_assign() - invoked everytime we succeed finding the sk
  bpf_sk_release() - invoked everytime we are done processing the sk

Anything else i missed?

cheers,
jamal
