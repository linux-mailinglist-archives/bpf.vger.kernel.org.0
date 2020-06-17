Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6841FD195
	for <lists+bpf@lfdr.de>; Wed, 17 Jun 2020 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQQJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Jun 2020 12:09:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:59686 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFQQJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Jun 2020 12:09:36 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jlad2-00088S-UV; Wed, 17 Jun 2020 18:09:32 +0200
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jlad2-000D4C-OF; Wed, 17 Jun 2020 18:09:32 +0200
Subject: Re: [PATCH bpf] tools, bpftool: Add ringbuf map type to map command
 docs
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200616113303.8123-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e4a66380-32ea-bf18-f00e-593ff69966c3@iogearbox.net>
Date:   Wed, 17 Jun 2020 18:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200616113303.8123-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25846/Wed Jun 17 14:58:48 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/16/20 1:33 PM, Tobias Klauser wrote:
> Commit c34a06c56df7 ("tools/bpftool: Add ringbuf map to a list of known
> map types") added the symbolic "ringbuf" name. Document it in the bpftool
> map command docs and usage as well.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
