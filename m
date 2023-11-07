Return-Path: <bpf+bounces-14449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B07E4C7D
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 00:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AA8281345
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793333066F;
	Tue,  7 Nov 2023 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eGRGPioV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="teset856"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D77210B
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 23:10:04 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F91990;
	Tue,  7 Nov 2023 15:10:03 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJjp4005490;
	Tue, 7 Nov 2023 23:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2TkODi4vvaw8iBZv3KVQzINFDwj61bfgmNMI8FJEOzA=;
 b=eGRGPioV74a3lb3O/sinRQbOWGFVsw3WyDdScGka5IDIkto2tYbwZO6WCICIpyvbqc+l
 vXsnlggLvTNnsu0gPvo2zRlxwbIkZM9BCTTdBIkvLhJvCHk8iOUzdqdYm1oRm5nIjScc
 ItgrdHYIt3GCJBV99fvdtSIH4wyYZOapes+t9ZSDbKFaMYuWpzwio7SED+ITgCe2r5nL
 o9bV/0IRr81aZ0ieJU8j2BDTpMlI5o04RbRPEXTOhssrMG6Xfvmz2JOqmMHc8e4I/oKU
 xwD1SZc5afN6gWTKDxYiqhYh/guy9NtflI901jWo2PWC/nDQOGLCc0XksIiveShK+gDv ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g639-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Nov 2023 23:08:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N3G8u000430;
	Tue, 7 Nov 2023 23:08:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvcxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Nov 2023 23:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5Cr9DD9twVzyB9yQrtX/h7aQnZ3FgRR7/PbqL4T+gkYNdCPdUQfccm7j3/R2E+/y1nOx516t7KQhGEznjCm2X+xo0F+UP0Sf8w3ssO/5K4AMzmLvSHs/eRqSrwnhDIbmENwCKFT0pSCGRIRF1DYuTvKUTYeSS2AWclj2kh57XVKfWs+Qw7THz+M/6uiRz5HjwgWwXyYc2W0VvDbuimHMvwxooXAnE8BNTLNStb+nMHHSpOIZxbK5+kHOyLpudxyo4Hq9KhrJH/L8I05CoYa1WlHQbAyRrMa7bQ4lg7/T5JDkkPlFi3QpVO9HpyP5NpY7YaSuXcvUaS/8u1zApdOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TkODi4vvaw8iBZv3KVQzINFDwj61bfgmNMI8FJEOzA=;
 b=DY0No2atI96paX/PdS2cKGRWnhDaJdpqrH2Bea9gV0hR15dif93U2kybpOymei1pw2w32njznXPTeaDN6zgT+CBrPL+FBU+cNLqMTC9frU1Mam09YmALJNpZQYVOMCcErq5OLZlYppC7gn8eLZyfIV+SHupS58/S8tj/iokwl08+hK0XJ51ZfEVikwxtMGvQ6KSCrKeqwPFF40vPulxMZpIJ3zQmLpoag5CRTj4BVv4kM3ZBi5OZQTJbRgYRmN1uqpo/tkJasliXVxAQ73gzIGMElaJIqHW95y8eqKL2C7Bz4zHbbsvOmhpL/6yq0X2kXk29PqTZCWu79dV+SgaXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TkODi4vvaw8iBZv3KVQzINFDwj61bfgmNMI8FJEOzA=;
 b=teset856oHjLv2i8vifkv9ofGtxUEFMlkCwHzC24trRTr0SKMlIWNNVRcc2MeDJ/9DQbuEdPFe6xfk22pZJQEpWm1TFMmcuYt4pFtUEe0KJ2stC6pgJYoFCiScjz7NNJnvb6kpPW7VnULCZCGvE3vuIdNZ+y5YK5xg2meQtw0ws=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:37 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:37 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        mingo@kernel.org, bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Subject: [RFC PATCH 61/86] treewide: bpf: remove cond_resched()
Date: Tue,  7 Nov 2023 15:07:57 -0800
Message-Id: <20231107230822.371443-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: c338200d-6a48-4df0-1cb2-08dbdfe67961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	45iQbgG5WDIS3h7izM1KzeNiajip4E1k9sUzo5KWQ4kbmeb7OKBfgtGYKPacLEnyQpvRRuZrzUL3yOfRp9zjzruFVSNE/ifh6xIB6pGCmrK7mY2kVblsvZ4PvDPS/bjiJEOKLwT2YSJPW3z1dgaZbKG3DMTIgelYomfFqAHl3P/SLx9ANs6aIuyqm+tbp+6IRKOqUj9rRGuRfvMta6ze75dckdUesiOCGM1QKvYDA1WB+ev/na1KwKWIsbin19dHoYG+M6MN8btOxrWPb3fMpzpMQNpb18YKG2tAV2f/gWnoy/ZNeElJ8aJ8sM6MVttEH3F6Eyha+r88m4auUe6IZIE1yJQa6qXqtZTLjtmq4ZW43fbrSJyEcFKuryVVLQkcWpEDZJaIowpZsoiSYKvU4Vc1xFUYHBcnx7GrPJPN9p1HpbGTOc0r8zU7Hfncsb+EPJKzk475x6Wt3ylGtxIfEh+ktf2wSi1+2ssoeevE5shqaEQedSvEO632v7qZUKI3fu8RveMoYmEvVMknMnfvxjH4+GBmbV0N9IJLMmPkvDY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(966005)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(66899024)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zIY2xLpmDCHiEUb/QzuAIb69NuIJaxDEDzn+zK3nRll+eW2pyUbnfgbUvSuu?=
 =?us-ascii?Q?YQHyD64qeo6t+prqbXNaw9Li8rbBTbKu7rDj+t7DrtjkEiOGdJocW2K3BUhH?=
 =?us-ascii?Q?YjC5A1QObzWRCfq/VeWiPk2H4a8kjTKdcIgLCYVoJfV8Te0MppLTyVnT6t/q?=
 =?us-ascii?Q?4mD1nwib+gRsFkhg2Mq/E4tV+mwtE9q6ZVT3bDR8LW1U/DVtPWrv6YVXgFrS?=
 =?us-ascii?Q?prMn56p1x02qae4pSbMOSbNGwDWPHnw1VIfMOhtYaS8o2XZeMqrRC191ar1w?=
 =?us-ascii?Q?jlLz4ahEJNmGjK1lttfIxLIwLe/wsswxuKGayTxe2nb5XfCkBR9ykg8vEipl?=
 =?us-ascii?Q?ymwJAND+lbRc5aPorKZbTZ6ebXgabzQt6iY0q09NPclgu1lKQm5//sQN5J2M?=
 =?us-ascii?Q?85RZG0D0PBxHzgQUIEmWHvTPoSA8+sRJKhlldwZ0RzSwOFgHNOEIcky70JN8?=
 =?us-ascii?Q?zB+X/xdUo/nDmlqrVXpBkZu7LXlYt9VqD6qxEH0zZyCzagztYyBz33SMpFCi?=
 =?us-ascii?Q?4iWOkx/WUFbynYNfW2OAM2fWhbY5Px4qfm6qg4QGdSR+tatAYagsHWVKCypg?=
 =?us-ascii?Q?6w5fM5GxWjKK6uOyc5TMtQq2HdAEP5JEWyP9S/Ld5vA+c0rDxyZRxucO3dnp?=
 =?us-ascii?Q?wwOT11j6aXE92aZL/Hhisupo9egFjh3wXs0la0VIS/Mo7cmFrgzVqvzbNJ1t?=
 =?us-ascii?Q?y8e8h9/SkbnxkcVqeFKvISil6ocFDN/e2OTB/OKfB+t0phuPNK8xcM54+98E?=
 =?us-ascii?Q?v+QMOwbsfty1nJUdGRVr+ic4rltSqavNR0SQd/D/9/8gOum0WOJi6/x6TzIj?=
 =?us-ascii?Q?xW0SZ9+lMKYqYheDwk/Tn3BlCCv1ch3fq+gZYM54u0F6Uvro162RO941v2X5?=
 =?us-ascii?Q?WFqRaZa37rJam+OaRdBRr1uauBEKhAZq+UJOnL0XJEByYQKst/I3vVQ/seGY?=
 =?us-ascii?Q?1ksiC9NRUiXk66EYqpGwxZMU99HRGBSOyEvhhbvLsKyXK+JGrkQcRc+YUBDq?=
 =?us-ascii?Q?98W4JDSsIL916uJiOyP/lSp+ov84nWE4h8EXDJ/T5qvHSkOQBLnqtKv14gfZ?=
 =?us-ascii?Q?Ybxeiff6D9/NB5/fxTRF1sFHtZ9/GJF3ILeQc/EiuWVbCQzey/VdPMRSQ+Vr?=
 =?us-ascii?Q?2pOKk81mRpUiPs2+h0nkOsIaPbDxw8BhlK8VK13br/EGDVSGMdJUUmLwqRMe?=
 =?us-ascii?Q?B38QakG2dK4rOWsej3lX8mTRa0s30uCDCbJ7I9Q1a8SNd06YdUXdvkbZJKSk?=
 =?us-ascii?Q?p6rps1Vze6/6/0hFN1s5ZAmva8upVHkIQ5KNooigM5hBKdpFsMTavYm9GqxY?=
 =?us-ascii?Q?i67QQ2A4PpTk8sjHZZ5pimUOQ1UWYdPuT4SLnuKBF6BAIzg/B8RVt8YpKQYB?=
 =?us-ascii?Q?gLaukcdhJkCfLP69Z72zcz/vBizmW4aRgcaH6rNSNv/JEJx+jNqYBudOJYT6?=
 =?us-ascii?Q?WDHTRemBXIw6DCoqECizfC2tje2gXXDwMabfrEr/C+S4Zrz2/Yk8bPikQ1Ff?=
 =?us-ascii?Q?Dg1Bylfu9ExVYWjLKJzEFH+qSGVKIJ8rmIaJUREt7A6+VpMuR2c7YzUqD1lf?=
 =?us-ascii?Q?GY6FWQv1mcivMBOVxTCsdgnFYaDndPraXghD5szV+Ras6K+PUyqYz5ItJD27?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?2hNcyKkEes53p/CS9vhBoCwM08woDmsGsrRGHkCyTSoKCklbPghqKQmAp41T?=
 =?us-ascii?Q?hK6blbM7SDOGtoXpEpIPtZGbEhhyQa7ofpNRnZU1saz8Ngdd8dXb4oeQfqer?=
 =?us-ascii?Q?uRUPZr+WBXku+HvPsXZlFDr18cD8AwVBVghgmjIYJBZ3f8eUlT9EseeL4ovK?=
 =?us-ascii?Q?DvCydIAH3q/I3g9vzZHd5bJbNwZ4buioJj2BXRejGzTvamRKZWHIIQht9QWr?=
 =?us-ascii?Q?MrrJXHlZlGcVROhIgUCWP7E/dGioyCTjdFjRdm0O7106hhjljjlj/zwnFXBw?=
 =?us-ascii?Q?ee6JEHTHqxJalHWbSjYq16vHTXuz0IBzScocFJpYC0YTcgaH4MJk0EQGyJ9c?=
 =?us-ascii?Q?GJmDIMNbnJUj65oTAFur6c/TPwAfzCjsPWzjww8/sJMdb18a6MdAdrSmAEDA?=
 =?us-ascii?Q?3iERYpwLGPwYD1PgqLfWm8bLQ2IHAIX27OaoZeUVZB2lUsS5yhzl2x7ndVz2?=
 =?us-ascii?Q?ac5ku6BWNKHGv0Yvg+jUr9nwBDFhMjxBXPlLn2DPGaA3yOoHBqh7n8aQEgKU?=
 =?us-ascii?Q?VMPjMBkyHQDvsXiI95qGc3T6b8P2UE8kwFUtFLxNysXX5gr03l5B+gO8ZELS?=
 =?us-ascii?Q?FVCL/zWikEQCR2l1McpgdQ7b9QCJUEKj5N4Rm2mRlal/APWRLP6bPjLVv3OL?=
 =?us-ascii?Q?PjN4Tm+plpbM+5w3i6EdlBe0oRHWeObyrO5EkrQco/oLookywUnMnoynN3dp?=
 =?us-ascii?Q?x2eBVDtDZwlmmWV5/sedPd0Ne616gK8Q6m1jJmhwnqQhJ/wF9tUf6VL12LRj?=
 =?us-ascii?Q?IyjgBXrNj1lFCGxxuoLohxiwF/n2AaUSLQm3cF2fIWenxhlCZoQ+UV5FnMx0?=
 =?us-ascii?Q?Am0I5V+4dyz1H/MuwvjfBkhfozDSDfP0jJjd/VAjkkP4JPr5xtV017bbY5Zv?=
 =?us-ascii?Q?BKdgD0w6I2qEYqmkNxETckCL/FGEoK4HVo1V8LmojM++yecjgjwhKeoJyASk?=
 =?us-ascii?Q?ZTgGCLi+33BXlQPy5l8TOYrl+2fp6Phho175NyBZu6Js2l8vHPzbo+CAAnSA?=
 =?us-ascii?Q?yFV+5aapCA6oX7dJeUqAQ/R0/wtvRNm8XGLgcPnZVRlSr5peOEHDq/zCD9Av?=
 =?us-ascii?Q?RlAEA6qDVU57sI59hzRuWwCqf+aQoza6pqJHZ+hrhWvFqdOcusjyKFpMYHiO?=
 =?us-ascii?Q?A/bnRqDLa2up7GZYtw3lBIX+6C+a2cnZ+wMVCgPAgXy69heNsCTaep32cnjD?=
 =?us-ascii?Q?JZACls+noZDFURR9xHPxJZyJ+MmCnQNV+7cKflX9yAyHD+n/ZKANBI7Pn/ns?=
 =?us-ascii?Q?Nx06QNUjy8ofAdbzrlf5cw/zG7PaA+g/GInao40S6l0eqEd0myNgpC1klXoK?=
 =?us-ascii?Q?4wIMzy09Cv+ezfzojCkIfjF7LfyjbJOg2vhxfEfgKClYCFR1gsNx6STUvXWx?=
 =?us-ascii?Q?Etr9U6Lq7M5SNH0OgAlLCDhpgevR44ZR4arXGArbpxj2i+6aGiFlRlKmQmi1?=
 =?us-ascii?Q?ish7j+1qKq5Z3uauKjJqHhu15PdylGdUnO6LBFfFByJLdtS66h9+h665HNm1?=
 =?us-ascii?Q?piABjnKihJcLzsWNfWqmbmof37ZsupAMAWoqnqNyfmlV9YPhrBevhdsIOeY3?=
 =?us-ascii?Q?SNbx4mPaIdBVcbdLfnjvh0Oc9842g0EnyUwaNPh/lTdT0T3HkGdVRgSCfEcU?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c338200d-6a48-4df0-1cb2-08dbdfe67961
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:37.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYJwWbBcOViNt5WLx3BW/Q773udAa00DMCR45MayZdvi0AKCo51X3AJV9UyeSkwN70wxvytDZqbc9OIm22fyKsvMC6CZsoheOcDxfEzBdts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-GUID: EIkfdFUdX3_47a-DUUBb5W6ITRtfIFuW
X-Proofpoint-ORIG-GUID: EIkfdFUdX3_47a-DUUBb5W6ITRtfIFuW

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

All the uses of cond_resched() here are from set-1, so we can trivially
remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/arraymap.c | 3 ---
 kernel/bpf/bpf_iter.c | 7 +------
 kernel/bpf/btf.c      | 9 ---------
 kernel/bpf/cpumap.c   | 2 --
 kernel/bpf/hashtab.c  | 7 -------
 kernel/bpf/syscall.c  | 3 ---
 kernel/bpf/verifier.c | 5 -----
 7 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..cb0d626038b4 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -25,7 +25,6 @@ static void bpf_array_free_percpu(struct bpf_array *array)
 
 	for (i = 0; i < array->map.max_entries; i++) {
 		free_percpu(array->pptrs[i]);
-		cond_resched();
 	}
 }
 
@@ -42,7 +41,6 @@ static int bpf_array_alloc_percpu(struct bpf_array *array)
 			return -ENOMEM;
 		}
 		array->pptrs[i] = ptr;
-		cond_resched();
 	}
 
 	return 0;
@@ -423,7 +421,6 @@ static void array_map_free(struct bpf_map *map)
 
 				for_each_possible_cpu(cpu) {
 					bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
-					cond_resched();
 				}
 			}
 		} else {
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..dfb24f76ccf7 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -73,7 +73,7 @@ static inline bool bpf_iter_target_support_resched(const struct bpf_iter_target_
 	return tinfo->reg_info->feature & BPF_ITER_RESCHED;
 }
 
-static bool bpf_iter_support_resched(struct seq_file *seq)
+static bool __maybe_unused bpf_iter_support_resched(struct seq_file *seq)
 {
 	struct bpf_iter_priv_data *iter_priv;
 
@@ -97,7 +97,6 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 	struct seq_file *seq = file->private_data;
 	size_t n, offs, copied = 0;
 	int err = 0, num_objs = 0;
-	bool can_resched;
 	void *p;
 
 	mutex_lock(&seq->lock);
@@ -150,7 +149,6 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 		goto done;
 	}
 
-	can_resched = bpf_iter_support_resched(seq);
 	while (1) {
 		loff_t pos = seq->index;
 
@@ -196,9 +194,6 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
 			}
 			break;
 		}
-
-		if (can_resched)
-			cond_resched();
 	}
 stop:
 	offs = seq->count;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8090d7fb11ef..fe560f80e230 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5361,8 +5361,6 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		if (!__btf_type_is_struct(t))
 			continue;
 
-		cond_resched();
-
 		for_each_member(j, t, member) {
 			if (btf_id_set_contains(&aof.set, member->type))
 				goto parse;
@@ -5427,8 +5425,6 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
 		if (!btf_type_is_modifier(t))
 			continue;
 
-		cond_resched();
-
 		in_tags = btf_type_is_type_tag(t);
 		while (btf_type_is_modifier(t)) {
 			if (!chain_limit--) {
@@ -8296,11 +8292,6 @@ bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
 		if (!targ_name)
 			continue;
 
-		/* the resched point is before strncmp to make sure that search
-		 * for non-existing name will have a chance to schedule().
-		 */
-		cond_resched();
-
 		if (strncmp(cands->name, targ_name, cands->name_len) != 0)
 			continue;
 
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index e42a1bdb7f53..0aed2a6ef262 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -290,8 +290,6 @@ static int cpu_map_kthread_run(void *data)
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
-		} else {
-			sched = cond_resched();
 		}
 
 		/*
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a8c7e1c5abfa..17ed14d2dd44 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -142,7 +142,6 @@ static void htab_init_buckets(struct bpf_htab *htab)
 		raw_spin_lock_init(&htab->buckets[i].raw_lock);
 		lockdep_set_class(&htab->buckets[i].raw_lock,
 					  &htab->lockdep_key);
-		cond_resched();
 	}
 }
 
@@ -232,7 +231,6 @@ static void htab_free_prealloced_timers(struct bpf_htab *htab)
 
 		elem = get_htab_elem(htab, i);
 		bpf_obj_free_timer(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
-		cond_resched();
 	}
 }
 
@@ -255,13 +253,10 @@ static void htab_free_prealloced_fields(struct bpf_htab *htab)
 
 			for_each_possible_cpu(cpu) {
 				bpf_obj_free_fields(htab->map.record, per_cpu_ptr(pptr, cpu));
-				cond_resched();
 			}
 		} else {
 			bpf_obj_free_fields(htab->map.record, elem->key + round_up(htab->map.key_size, 8));
-			cond_resched();
 		}
-		cond_resched();
 	}
 }
 
@@ -278,7 +273,6 @@ static void htab_free_elems(struct bpf_htab *htab)
 		pptr = htab_elem_get_ptr(get_htab_elem(htab, i),
 					 htab->map.key_size);
 		free_percpu(pptr);
-		cond_resched();
 	}
 free_elems:
 	bpf_map_area_free(htab->elems);
@@ -337,7 +331,6 @@ static int prealloc_init(struct bpf_htab *htab)
 			goto free_elems;
 		htab_elem_set_ptr(get_htab_elem(htab, i), htab->map.key_size,
 				  pptr);
-		cond_resched();
 	}
 
 skip_percpu_elems:
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d77b2f8b9364..8762c3d678be 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1695,7 +1695,6 @@ int generic_map_delete_batch(struct bpf_map *map,
 		bpf_enable_instrumentation();
 		if (err)
 			break;
-		cond_resched();
 	}
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
 		err = -EFAULT;
@@ -1752,7 +1751,6 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
 
 		if (err)
 			break;
-		cond_resched();
 	}
 
 	if (copy_to_user(&uattr->batch.count, &cp, sizeof(cp)))
@@ -1849,7 +1847,6 @@ int generic_map_lookup_batch(struct bpf_map *map,
 		swap(prev_key, key);
 		retry = MAP_LOOKUP_RETRIES;
 		cp++;
-		cond_resched();
 	}
 
 	if (err == -EFAULT)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 873ade146f3d..25e6f318c561 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16489,9 +16489,6 @@ static int do_check(struct bpf_verifier_env *env)
 		if (signal_pending(current))
 			return -EAGAIN;
 
-		if (need_resched())
-			cond_resched();
-
 		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
 			verbose(env, "\nfrom %d to %d%s:",
 				env->prev_insn_idx, env->insn_idx,
@@ -18017,7 +18014,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			err = -ENOTSUPP;
 			goto out_free;
 		}
-		cond_resched();
 	}
 
 	/* at this point all bpf functions were successfully JITed
@@ -18061,7 +18057,6 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 			err = -ENOTSUPP;
 			goto out_free;
 		}
-		cond_resched();
 	}
 
 	/* finally lock prog and jit images for all functions and
-- 
2.31.1


