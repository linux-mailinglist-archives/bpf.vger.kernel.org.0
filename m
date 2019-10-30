Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33E6EA02E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJ3PyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 11:54:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:42462 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfJ3PyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:11 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iPqIR-0006H2-9m; Wed, 30 Oct 2019 16:54:07 +0100
Date:   Wed, 30 Oct 2019 16:54:07 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test narrow load from
 bpf_sysctl.write
Message-ID: <20191030155407.GA5669@pc-66.home>
References: <20191029143027.28681-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029143027.28681-1-iii@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25618/Wed Oct 30 09:54:22 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 29, 2019 at 03:30:27PM +0100, Ilya Leoshkevich wrote:
> There are tests for full and narrows loads from bpf_sysctl.file_pos, but
> for bpf_sysctl.write only full load is tested. Add the missing test.
> 
> Suggested-by: Andrey Ignatov <rdna@fb.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
