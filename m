Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF825FE7E
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgIGQR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:17:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730462AbgIGQOi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Sep 2020 12:14:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087G2nNo145672;
        Mon, 7 Sep 2020 12:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=KUO1qaYxj4EQCgBfTgibsytanxn9bUmcpHxsIceG490=;
 b=qPvTQ6ZrllwOg8ukrLXrBb0ImIb676qK08uf4ckiHwcOGJr7wrwc/LhsELKtKXeTbJMR
 WVXYny0CKr9oCe/D77BRj6T4LPi5g/x7PNOxedKQy9EPiq05ozqpaH7EYOZ5ixhuhHy5
 JRTxs0km0HQbNIPtDoLEe7DMMWNZ2wU8PyJV/CofOeXpF3qtMytZLtHFSoY1T+nHN52w
 q7tYQ2DvBG/0ViN0mhmkBoAAuButR0RmmvSL14mb4jfRcTjyOiX3T1QCtLh5GljCcL4P
 qGai4zl1ZBqLrYn1T5r9EBCuuJJaQ/trjoHs6OSnEm4QFehqHFcqc0ljTsl4KbV34374 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dpmwjnpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 12:14:13 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087G2oxm145846;
        Mon, 7 Sep 2020 12:14:13 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33dpmwjnnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 12:14:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087GEAIk019254;
        Mon, 7 Sep 2020 16:14:10 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8ajpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 16:14:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087GE7jf32965004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 16:14:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B32AEA405E;
        Mon,  7 Sep 2020 16:14:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1D6A4057;
        Mon,  7 Sep 2020 16:14:07 +0000 (GMT)
Received: from sig-9-145-16-19.uk.ibm.com (unknown [9.145.16.19])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 16:14:07 +0000 (GMT)
Message-ID: <7510248caa08a521150b3089e12ded4312eaf14b.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Mon, 07 Sep 2020 18:14:07 +0200
In-Reply-To: <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
         <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
         <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_10:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=3 mlxscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070155
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-03 at 19:13 +0300, Yauheni Kaliuta wrote:
> On Thu, Sep 3, 2020 at 6:10 PM Daniel Borkmann <daniel@iogearbox.net>
> wrote:
> > On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> > > On code patching it may require to update branch destinations if
> > > the
> > > code size changed. bpf_adj_delta_to_imm/off increments offset
> > > only
> > > if the patched area is after the branch instruction. But it's
> > > possible, that the patched area itself is a branch instruction
> > > and
> > > requires destination update.
> > 
> > Could you provide a concrete example and walk us through? I'm
> > probably
> > missing something but if the patchlet contains a branch
> > instruction, then
> > it should be 'self-contained'. In the sense that the patchlet is a
> > 'black
> > box' that replaces 1 insns with n insns but there is no awareness
> > what's
> > inside these insns and hence no fixup for that inside
> > bpf_patch_insn_data().
> 
> The code is
> Disassembly of section classifier/test:
> 
> 0000000000000000 test_cls:
>        0:       85 01 00 00 ff ff ff ff call -1
>                 0000000000000000:  R_BPF_64_32  f7
>        1:       95 00 00 00 00 00 00 00 exit
> 0000000000000000 f1:
>        0:       61 01 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
>        1:       95 00 00 00 00 00 00 00 exit
> [...]
> 00000000000000a8 f7:
>       21:       85 01 00 00 ff ff ff ff call -1
>                 00000000000000a8:  R_BPF_64_32  f6
>       22:       95 00 00 00 00 00 00 00 exit
> 
> Before the patching the bytecode is:
> 
> 00000000: 85 01 00 00 00 00 00 16 95 00 00 00 00 00 00 00
> 00000010: 61 01 00 00 00 00 00 00 95 00 00 00 00 00 00 00
> [...]
> 
> It becomes
> 
> 
> 00000000: 85 01 00 00 00 00 00 2b bc 00 00 00 00 00 00 01
> 00000010: 95 00 00 00 00 00 00 00 61 01 00 80 00 00 00 00
> 
> at the end, the 2b offset is incorrect.
> 
> With that zext patching the code "85 01 00 00 00 00 00 16" is
> replaced
> with "85 01 00 00 00 00 00 16 bc 00 00 00 00 00 00 01", 0x16 is not
> changed, but the real offset has changed.
> 
> > So, if we take an existing branch insns from the code, move it into
> > the
> > patchlet and extend beginning or end, then it feels more like a bug
> > to the
> > one that called bpf_patch_insn_data(), aka zext code here. Bit
> > puzzled why
> > this is only seen now, my impression was that Ilya was running
> > s390x the
> > BPF selftests quite recently?
> 
> I have not investigated why on s390 it is zext'ed, but on x86 not,
> it's related to the size of the register when it returns 32bit value.
> There may be a bug there as well.
> 
> I did think a bit more on your words, making the zext patching code
> specially check jumps and adjust the offset in the patchlet looks
> more
> correct. But duplicates the existing code. I should spend more time
> on
> that.

I guess copying the existing insn into the patchlet was introduced
because there is nothing like bpf_insert_insns()? I.e. we can replace
an existing insn with a patchlet, but cannot append anything to it.
Would introducing such function solve this problem?

