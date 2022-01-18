Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91520493111
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 23:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiARWym (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 17:54:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1792 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349892AbiARWyl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Jan 2022 17:54:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20IM4M6R020143;
        Tue, 18 Jan 2022 14:54:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aUckHWNxfL7Dl3Z0cSNTLL7yvXpBPefIw6M+NlaMCrM=;
 b=VGgAIVD3LUV6aE2f9hh7gJmSVVka5//zFbXX4njPcWVhBDKYp0j1qtITu4c2S60erj80
 F0/4eonJ7qklTHTQu02W9S12t9H8NsowDRZMdOA2O3jKs0/GBv9UoE5G/dgP26pqW91e
 gUTDg65YWLzuy51B2YIb3ESMm7Me3VvkscQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp16qadt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Jan 2022 14:54:31 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 14:54:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuLv0uCjw3+6yv52gCsELEEe9ya0BiRvAXzp5TOBRSsZCAUgwnDc+0N7rcsHrfVI9U6NXpPAy2yfjkSAaQolLB2rVg1PnWREYW6tTNKq+nOGvA88NGzi0FD/cF7OkBa939NzANp6qw33Ul30oNIwbPAUa145y1HEwKvrhZIe177OgcI0WyOuDb2Ja+sjupmMJhp+JQ1zOrgUZZfb4d7SapC5P45muCjJ/bMEBXKKnr8s9m1bZrUFbZJ5WV+riKWf9L1iS2mJwSJgB27k7HHNqvz5lUjFBZkirS1HgYYNK++OX3VYaYBMp4Ri5LtODOnQI9hJoUiH1xFWgxU1D0PU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUckHWNxfL7Dl3Z0cSNTLL7yvXpBPefIw6M+NlaMCrM=;
 b=jmhspBJT+XqY4SQOKg2jaH9lhpriZAcspUfYKRnwQ0zwVRcwJKUuDqm0STi71TH4satuhfJEmqndv3aCZv+qkNE6Z0ixl86w2SbRWLg6N6MEZDvDj1fkLf8f1LK3RYCYO5X8Dbe9FSXGavgvmxkz2tSBsLL4WQ0Ek5Aq48cMv86mNr52IOb7o1p5qQjYwrnC2lQz8GHc5Rp7WYauMpWwdYdA9QnjPDSyOYcYvuHCt0ch6TxIaF2cqTgUfSL8zhZqX494t6X+CrU3o/i5gnla+DVpEYPxPTaNE2UawW3MiQjxIKUt8sReQ4rMwzOXIgxV0FgXoFcARkB+P5y1mn1iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MWHPR15MB1549.namprd15.prod.outlook.com (2603:10b6:300:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 22:54:28 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:54:28 +0000
Date:   Tue, 18 Jan 2022 14:54:24 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Huichun Feng <foxhoundsk.tw@gmail.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@redhat.com>,
        <peterz@infradead.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YedFIIK+a7AbsfPt@carbon.dhcp.thefacebook.com>
References: <20210916162451.709260-1-guro@fb.com>
 <20220115082924.4123401-1-foxhoundsk.tw@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220115082924.4123401-1-foxhoundsk.tw@gmail.com>
X-ClientProxiedBy: MWHPR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:300:93::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73f8c725-a978-42ca-3d49-08d9dad57b97
X-MS-TrafficTypeDiagnostic: MWHPR15MB1549:EE_
X-Microsoft-Antispam-PRVS: <MWHPR15MB15495445C58959BB412C2399BE589@MWHPR15MB1549.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5e8v/TvkTKNNBNs8y+PCOF4zFhG8u47Mq7QGWbCgQOaCDLB2RIXtlJl/z79IhjZxiHqRvWScrWpYSkRsWWe+GEtDNtVjgflHagq/edcTxoHwE5MajQwtaYELtBJUmlDdw75jVB9uNZFog1NDD9qzq+s9mXsgtgv1/wtuOZ9x+E5dMY0aFyqInL9jk7gWniHjR+5UdV310+cU+yLoJhH8BNPXWcNP/2Y/rkxgqa1DjK7O/5eNo8HNMUPj0XLQkMFMqNriRRHqjCWBI3PALLa5j4dd39j4LOR7b4T6a+VAI9PYYyQNi4FDsxR4TWTIPevPm985FginfTEqHT56wa4e6IdQBET6MW11wwd9AJ5h07yDHsflEg1PLDpnxgR7jZbyYHCyTbRxd1aiKyKq0gsBqp+kWIM7H5OvHXeSiI+q0MNLCigIuBovSKJ3R6vsF1Bhbhi5/nVFE1rRO0gTmgrfrEP9ayGXIOC33blAEwqZHtZZWLPx4UH6Y2yvqN1s7UI9enhgYTyUhDM/V2L2iTyrY5+fIk4svY55Tnch0LmT2WopKYUHwxXgB5Ms98f8QOEpMxpxuvPYyPqix+PfoeMMONYVxYjzuXUcOMi63n+PChbnPzqxx8OA80gKjSvB3acHyYGo9591Ym++5O98H0HQUkh6dcuSQ7iXynXjQcLdEYhagKX2zQSKwvIJvNcFXMI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(6512007)(9686003)(508600001)(38100700002)(4326008)(52116002)(6666004)(316002)(66476007)(66556008)(5660300002)(8676002)(6916009)(66946007)(6486002)(6506007)(2906002)(8936002)(86362001)(4744005)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?egrY/1G3/UYKEQiE2WlztrAjtubjFnKiKneOpMMSc4dkYLzAscwkpWb/AYZm?=
 =?us-ascii?Q?VlSDvF35adLGOkyp0TogFKmk8zXwxwNbxWU9UA2/yPQH7mES5Mkxkdoow6e5?=
 =?us-ascii?Q?mSLy563v87Ah2e2JgqUM/AONHBY/l7ntfp6zSvVF8pbEDU1b0FvPF2mV6mXO?=
 =?us-ascii?Q?PLpxDyAleNUE/bRY3VMcEoJJunihbtNUuKJU16O5qE/qOHU0g30c2y6/tbHb?=
 =?us-ascii?Q?WsM+SgVkuWaxfuLGAdzN1s/4TZcsJBwA4tOLxPFTmdLzC5J60M4ReuwkTdku?=
 =?us-ascii?Q?LSsI78MQ68VzbWWgnPX63Bt/HDtP4VeUmwsLcDtzC3PHb13vbIUgLkP0awCK?=
 =?us-ascii?Q?cnhLudv/i4X2z++fgAN1abFmWE7v092GQQee2TG2W3KJl0StiRg8WraWN6/h?=
 =?us-ascii?Q?Gh9bG601ilasJF1lOI06m+MOzu9/ZP+0/ckEQSUbcg40lGnslOnDXvdD9Af9?=
 =?us-ascii?Q?Oy5oRS2cjZQUyMxMlm/5UaL9p6ZYh4qz880aJx66iaIbBhzy66vDNOoUR7hF?=
 =?us-ascii?Q?HoHa0Ulf9wZheij4F/g61kqCyaOx2yc4M9gQnlcUhRHx0o1gQ06fpzD5PoKA?=
 =?us-ascii?Q?FZ61d4lErCiqWS7hbPnqgnu94sGwFYz376DJ4neto4PZTQcFhmPGGXhLvfU2?=
 =?us-ascii?Q?fUlawbvoWPPprKVCShaUWKNKjkl5VSkPpOlYRVAZV+RUgabXdN3zSe8fTtW6?=
 =?us-ascii?Q?X2jKmQnUSdULZPM2WaErMdbp93M5MudpBwEDfCWHKUp8uJEZ43loyo+O7QD5?=
 =?us-ascii?Q?1sVg8F9eSA7Wx70MwWnuIcSSL5ZaOtLe7bbR/QiWbrWGWgdditRfVaEp3bxY?=
 =?us-ascii?Q?o8/kN5IhlMYapTrY2qF48xyK4gX9HSqGQ9xdEWfw3pXDQayP8YduQd+F+H+y?=
 =?us-ascii?Q?8b12nr8+mOXYRKoD6WTFMRe/HLhsrVQJbYsqSptPFqz8L5vmFcxRUwzBZd74?=
 =?us-ascii?Q?5kC0qqn+PbF951aBAf/v5nRw4dvDQvwcpAW92CYip+tFCvK7UNosUcTrw9fW?=
 =?us-ascii?Q?9bPu84vUuAeDvsKNAeoQzipTxNErMEKAYEc8YZAx43lnDXsYHUzrgzjSJlHa?=
 =?us-ascii?Q?38VhWiVq7/RpeDF5SLHh0OqX7o11jdrvUvy3/ZCJ7pkBR++lGIidbA02FaOS?=
 =?us-ascii?Q?srSLVXjMuHOQMxSuZWv2OV1mkgnLleOQl4eTHaiIRonzvS79PdXEtJBiiING?=
 =?us-ascii?Q?w3e2/rUa5Waeryi0kERx0e1JZDEYniy0XFURxwLoZ0H/uxeBE3n4cpF5Qfvt?=
 =?us-ascii?Q?t+NbrggcNP/cHGZPrkzUtGJOIzgqCbWoCwP/WM1GYlI2IWRAyirNEtwN8bZ7?=
 =?us-ascii?Q?VfFdroj9g+htjdan3/AacwvIgpaha25kS4r5unm9DuLInmDqkl6lKVcEHxdu?=
 =?us-ascii?Q?LQXoG8FLemsREvCuNCiO2QAPZ9qXl4J3/VG7nF9HHJAtFI7xTgD7K0sTZwcw?=
 =?us-ascii?Q?xjZaA1LCYd2BzzrhDqngu0I3LLTMNQsdlwS9olPelez6J5hin5PRZ8KEvev5?=
 =?us-ascii?Q?Pn5vs/MrSrugDuqLas4XIOS7LPVkPSPyyLwRqf3FtHIx79ermxQ5DKEJAuD2?=
 =?us-ascii?Q?DsdhPV/+RpYKugG+nbK/WRK2JvgOEI8qQ9J8VzYf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f8c725-a978-42ca-3d49-08d9dad57b97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 22:54:28.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 736p/Nrv6BQJxBM9hAWgPKq9z+JtCzarXr9UFwo6Va9hlBG8itinfmAn3m0Eu8Yb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1549
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8tJ7Tr7gg_V6uVuJ9DG9rYc2y8A5uF2P
X-Proofpoint-GUID: 8tJ7Tr7gg_V6uVuJ9DG9rYc2y8A5uF2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 15, 2022 at 04:29:24PM +0800, Huichun Feng wrote:
> Hi Roman and the list,

Hello Huichun!

> 
> I have a naive question regarding BPF hook for sched.
> 
> Given that BPF can also be attached to tracepoint, why do we add a BPF prog
> type specific to sched?

Tracing programs can have return values as well, see kretprobes.

> 
> The reason I can come up with is that sched BPF can have retval to drive the
> scheduling decision in static branch, whereas tracepoint is not able to do this.
> Is it mainly because of this or anything else?

Well, you are right that right now there is no strict necessity to
introduce a new prog type (aside from static branch mechanism you
mentioned), however I believe it's useful in a long run. Sched
programs might be able to use a different set of helpers, maybe there
will be some additional restrictions, etc. It's an RFC version of the
patchset and any ideas, suggestions and critic are highly welcome!

Thanks!
