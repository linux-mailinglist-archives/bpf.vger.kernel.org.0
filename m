Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE6A1D17F9
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 16:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbgEMOz1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 10:55:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:48908 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbgEMOz1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 10:55:27 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYsn7-0002Vv-9O; Wed, 13 May 2020 16:55:25 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jYsn6-000UL0-Ov; Wed, 13 May 2020 16:55:25 +0200
Subject: Re: [PATCH] selftests/bpf: install generated test progs
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
References: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <396aa431-82fc-b93e-7c69-3d215d1d9939@iogearbox.net>
Date:   Wed, 13 May 2020 16:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25811/Wed May 13 14:11:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/13/20 4:17 AM, Yauheni Kaliuta wrote:
> Before commit 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
> test_maps w/ general rule") selftests/bpf used generic install
> target from selftests/lib.mk to install generated bpf test progs by
> mentioning them in TEST_GEN_FILES variable.
> 
> Take that functionality back.
> 
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
> test_maps w/ general rule")
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Applied, thanks!
