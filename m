Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376C421E6A
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJEFwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 01:52:11 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52949 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231142AbhJEFwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 01:52:11 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HNmrr00g5z9sVN;
        Tue,  5 Oct 2021 07:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MkznaSMcms_y; Tue,  5 Oct 2021 07:50:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HNmrq66T1z9sV4;
        Tue,  5 Oct 2021 07:50:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B505F8B770;
        Tue,  5 Oct 2021 07:50:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XM5qyo8sPpt2; Tue,  5 Oct 2021 07:50:19 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.122])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D3268B765;
        Tue,  5 Oct 2021 07:50:18 +0200 (CEST)
Subject: Re: [PATCH 3/9] powerpc/bpf: Remove unused SEEN_STACK
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <92fcd53a43dede52fbba52dc50c76042a6ce284c.1633104510.git.naveen.n.rao@linux.vnet.ibm.com>
 <bdadfd21-7e39-5984-43b9-818f1660ccaf@csgroup.eu>
 <1633369544.ekqufta9bg.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a9904ed3-c9fc-d86f-a720-de0a7e7a8938@csgroup.eu>
Date:   Tue, 5 Oct 2021 07:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1633369544.ekqufta9bg.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Le 04/10/2021 à 20:11, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>>
>>
>> Le 01/10/2021 à 23:14, Naveen N. Rao a écrit :
>>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>
>>> SEEN_STACK is unused on PowerPC. Remove it. Also, have
>>> SEEN_TAILCALL use 0x40000000.
>>
>> Why change SEEN_TAILCALL ? Would it be a problem to leave it as is ?
>>
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> I prefer the bit usage to be contiguous. Changing SEEN_TAILCALL isn't a 
> problem either.
> 

Well you are adding SEEN_BIG_PROG in following patch so it would still 
be contiguous at the end.

I don't really mind but I thought it would be less churn to just leave 
SEEN_TAILCALL as is and re-use 0x40000000 for SEEN_BIG_PROG.

Anyway

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
