Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D232EE95C
	for <lists+bpf@lfdr.de>; Thu,  7 Jan 2021 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhAGW4i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jan 2021 17:56:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46286 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGW4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 17:56:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107Mo04u136743;
        Thu, 7 Jan 2021 22:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=corp-2020-01-29;
 bh=PVCzoGUMBLf8oDCMi85vOqx1ZyN/hunVn/8TU9k+2NA=;
 b=oTvvgohHvFMT2yg//e2GI5brcNx6K00B8IJgxyXIbYA+GjjYxxXDs+Ng4f2kNv5MWhMC
 cBjUvJO5ANHIdD2JNCq2yNYqHbbLLbmWtP3v5advEpqnUDAC2eIxhycJM7HPtw3Zy0ft
 v3GhxKjk6wAtEUpHh7wyHCkWdub57lJL9rqhZwk18XDwTp9g8bOCx0pBWPBJpbhD8Oh9
 DooJoigeGf6Yss4kzHcy+xL12KMNmv+ra8eft8EM4CTdaBxs1VKbT9DPvx2mU7v9QXxC
 PMFf0NGkIF5MuLId/uB3K96G4eeH0tgPeEGyQbavkX0GQSESZCRQSlSZHa6YJep89Lv3 Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35wcuxy5a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 22:55:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107MoWwg088171;
        Thu, 7 Jan 2021 22:55:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4rejquk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 22:55:42 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107MteHO005175;
        Thu, 7 Jan 2021 22:55:41 GMT
Received: from dhcp-10-175-199-185.vpn.oracle.com (/10.175.199.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 14:55:40 -0800
Date:   Thu, 7 Jan 2021 22:55:34 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
cc:     Brendan Jackman <jackmanb@google.com>,
        KP Singh <kpsingh@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: BPF ring buffer variable-length data appending
In-Reply-To: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
Message-ID: <alpine.LRH.2.23.451.2101072226350.6677@localhost>
References: <CAEf4BzZw5Zt92PHMP=3+aKEiJNP6aG6+Xpw5BLK2mQAohVPyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070128
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 7 Jan 2021, Andrii Nakryiko wrote:

> We discussed this topic today at office hour. As I mentioned, I don't
> know the ideal solution, but here is something that has enough
> flexibility for real-world uses, while giving the performance and
> convenience of reserve/commit API. Ignore naming, we can bikeshed that
> later.
> 
> So what we can do is introduce a new bpf_ringbuf_reserve() variant:
> 
> bpf_ringbuf_reserve_extra(void *ringbuf, __u64 size, __u64 flags, void
> *extra, __u64 extra_sz);
> 
> The idea is that we reserve a fixed size amount of data that can be
> used like it is today for filling a fixed-sized metadata/sample
> directly. But the real size of the reserved sample is (size +
> extra_sz), and bpf_ringbuf_reserve_extra() helper will bpf_probe_read
> (kernel or user, depending on flags) data from extra and put it right
> after the fixed-size part.
> 
> So the use would be something like:
> 
> struct my_meta *m = bpf_ringbuf_reserve_extra(&rb, sizeof(*m),
> BPF_RB_PROBE_USER, env_vars, 1024);
> 
> if (!m)
>     /* too bad, either probe_read_user failed or ringbuf is full */
>     return 1;
> 
> m->my_field1 = 123;
> m->my_field2 = 321;
> 
> 
> So the main problem with this is that when probe_read fails, we fail
> reservation completely(internally we'd just discard ringbuf sample).
> Is that OK? Or is it better to still reserve fixed-sized part and
> zero-out the variable-length part? We are combining two separate
> operations into a single API, so error handling is more convoluted.
> 
> 
> Now, the main use case requested was to be able to fetch an array of
> zero-terminated strings. I honestly don't think it's possible to
> implement this efficiently without two copies of string data. Mostly
> because to just determine the size of the string you have to read it
> one extra time. And you'd probably want to copy string data into some
> controlled storage first, so that you don't end up reading it once
> successfully and then failing to read it on the second try. Next, when
> you have multiple strings, how do you deal with partial failures? It's
> even worse in terms of error handling and error propagation than the
> fixed extra size variant described above.
> 
> Ignoring all that, let's say we'd implement
> bpf_ringbuf_reserve_extra_strs() helper, that would somehow be copying
> multiple zero-terminated strings after the fixed-size prefix. Think
> about implementation. Just to determine the total size of the ringbuf
> sample, you'd need to read all strings once, and probably also copy
> them locally.  Then you'd reserve a ringbuf sample and copy all that
> for the second time. So it's as inefficient as a BPF program
> constructing a single block of memory by reading all such strings
> manually into a per-CPU array and then using the above
> bpf_ringbuf_reserve_extra().
> 

I ran into a variation of this problem with the ksnoop tool [1]. I'd hoped 
to use ringbuf, but the problem I had was I needed to store a series of N 
strings into a buffer, and for each I needed to specify a maximum size (for 
bpf_snprintf_btf()).  However it was entirely possible that the 
strings would be a lot smaller, and they'd be copied one after the other, 
so while I needed to reserve a buffer for those N strings of
(N * MAX_STRINGSIZE) size as the worst case scenario, it would likely be a 
lot smaller (the sum of the lengths of the N strings plus null 
termination), so there was no need to commit the unused space.  I ended up 
using a BPF map-derived string buffer and perf events to send the events 
instead (the code for this is ksnoop.bpf.c in [1]).

So all of this is to say that I'm assuming along with the reserve_extra() 
API, there'd need to be some sort of bpf_ringbuf_submit_extra(ringbuf, 
flags, extra_size) which specifies how much of the extra space was used? 
If that's the case I think this approach makes ringbuf usable for my 
scenario; the string buffer would effectively all be considered extra 
space, and we'd just submit what was used.

However I _think_ you were suggesting above combining the probe read and 
the extra reservation as one operation; in my case that wouldn't work 
because the strings were written directly by a helper (bpf_snprintf_btf())
into the target buffer. It's probably an oddball situation of course, but 
thought I'd better mention it just in case. Thanks!

Alan

[1] https://lore.kernel.org/bpf/1609773991-10509-1-git-send-email-alan.maguire@oracle.com/
