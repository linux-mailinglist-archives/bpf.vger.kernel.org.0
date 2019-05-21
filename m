Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E532585B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEUTfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 15:35:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55010 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfEUTfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 15:35:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LJTIZj132226;
        Tue, 21 May 2019 19:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cMKeJH1/+w6ckA+Plj+KPekHQ1V3sUSloZDX68SpRHQ=;
 b=vt7daWwdZvAy02Q64z6WkqQuG8EajiFg7Ii5icaw5Z8RTKgXg3juq570CqTCC0CfoVBo
 dYSrRffV9g1a3fVjXlJ/fiT2VLt6w410lDM2MHBC8bwR0A3wMC6Iq6LkZi6RSV8/wNII
 qqtoIL6sSRPogUsSifInxpJAzzC/a2AyJPEK6Vy1IX0wfZEHv/XkOKimXN+bljesXJnn
 z7yjTF3/5DOX/GVqPLJvyHpUaHz1Fb/kR19l61jNmcXNBjSPVJrKbEl8qdkwD823KCiH
 NTpOF6iWpnlyN/ZtcrN1uJV8H0TnIBAFtjGfcQmiH3L71Q42SnK2llAxFuyrBykAvioO cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sj9ftfqdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 19:35:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LJYqMX135056;
        Tue, 21 May 2019 19:35:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2skudbjucf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 19:35:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LJZ2KH015125;
        Tue, 21 May 2019 19:35:02 GMT
Received: from termi.oracle.com (/10.175.36.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 19:35:02 +0000
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Edward Cree <ecree@solarflare.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>, <binutils@sourceware.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
        <CAADnVQJcfnEh4_ok1o9oWNiaBAdd-2XHiguu1FvPZdnAuXuWBg@mail.gmail.com>
        <9430cd91-9344-8bb7-27da-c6809f876757@solarflare.com>
Date:   Tue, 21 May 2019 21:34:42 +0200
In-Reply-To: <9430cd91-9344-8bb7-27da-c6809f876757@solarflare.com> (Edward
        Cree's message of "Tue, 21 May 2019 20:02:24 +0100")
Message-ID: <87tvdnlhyl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210120
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=892 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210120
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


    On 21/05/2019 19:18, Alexei Starovoitov wrote:
    > I think Ed had an idea on how to specify BTF in asm syntax.
    Specifically, see [1] for BTF as implemented in ebpf_asm, though note
    that it doesn't (yet) cover .btf.ext or lineinfo.
    
    [1]: https://github.com/solarflarecom/ebpf_asm/tree/btfdoc#type-definitions

Thanks for the reference.  I just checked out your `btfdoc' branch.  I
will take a look.

Where would you like to get feedback/suggestions/questions btw?
bpf@vger.kernel.org?
