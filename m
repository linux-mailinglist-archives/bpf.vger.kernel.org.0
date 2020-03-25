Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3019347D
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 00:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYXUi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 19:20:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:48398 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 19:20:38 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jHFK6-0003MZ-KC; Thu, 26 Mar 2020 00:20:34 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jHFK6-000INY-DR; Thu, 26 Mar 2020 00:20:34 +0100
Subject: Re: [PATCH] libbpf: remove unused parameter `def` to
 get_map_field_int
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200325113655.19341-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dc473b26-a33e-d778-3c78-24fe80b7432f@iogearbox.net>
Date:   Thu, 26 Mar 2020 00:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200325113655.19341-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25762/Wed Mar 25 14:09:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/25/20 12:36 PM, Tobias Klauser wrote:
> Has been unused since commit ef99b02b23ef ("libbpf: capture value in BTF
> type info for BTF-defined map defs").
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
