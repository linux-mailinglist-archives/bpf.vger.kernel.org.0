Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF4EA0F8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2019 17:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfJ3P4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Oct 2019 11:56:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:42726 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfJ3P4K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 11:56:10 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iPqKN-0006PE-5w; Wed, 30 Oct 2019 16:56:07 +0100
Date:   Wed, 30 Oct 2019 16:56:06 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpf: add s390 testing documentation
Message-ID: <20191030155606.GB5669@pc-66.home>
References: <20191029172916.36528-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029172916.36528-1-iii@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25618/Wed Oct 30 09:54:22 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 29, 2019 at 06:29:16PM +0100, Ilya Leoshkevich wrote:
> This commits adds a document that explains how to test BPF in an s390
> QEMU guest.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
