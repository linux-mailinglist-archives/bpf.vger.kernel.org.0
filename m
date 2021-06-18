Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8AC3AD5AE
	for <lists+bpf@lfdr.de>; Sat, 19 Jun 2021 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhFRXPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 19:15:38 -0400
Received: from mail-eopbgr670067.outbound.protection.outlook.com ([40.107.67.67]:25556
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230024AbhFRXPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 19:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgHirpSFqKFfvACSgU9/afyXt+4pdM2VuscY2BtXRszOLJjWnqaPyk7wVmATCMfOAencpJFAyXAaxFawwGEWOKoI+kq6/33FeIDNg8OWx+imMr5LYPaSq/+xJqaD+pDcPf4wi1yR8Kzwr2CXYeQK94NtFilqPU2ZctKrHEYWtLcV4epihEFxcdKw3MNYWskWVXb4swb0lnW4lYrN10phnc9a8DbBjlOA/qyNgtywob+a5TXs9CkfCPMfrLHr5j7ZYjmGY3Cf8mCT6sftpzrOePD+gnchf4Je+HVRQBUC8JNIvqSMNdGQo684gIHVv0e1DIYU47nNFmSTsm2KKhyaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtkJQh5CGL1bxKP3H0YD7xZJ69/wAVsCneNFhGRBwRA=;
 b=DiUcG+VQ0cLN2qGIcFPzwRgfn7JngGuNlvXGUoBO2j7pYepWtgQg+cj/2pu3AlqT3oZXPgXNcG+5PWX4MFpk6L9o+VOn+D9R0oBfB9fHPyn67ddrFUphn+8BYehDX4yvryTaah1oNjo2mspyPyDhMlesuNmzKlCHHtMX40ZON34bX+Ikr6VEWxi0wVlgZJU39Pp4U1gVriYtETibCK3bA6xisJT1WyfYYF+E7bu0ApZagGROtIqsTuolb8FLE1IOf5tbKM5mf6I9Co1Xpw5J/ynFBDn3WXfXGbSSNmMojemPDHiONsnW3zwloSBo8a97fyX9pzzEfmJhGR2Kbyndlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=165gc.onmicrosoft.com; dmarc=pass action=none
 header.from=165gc.onmicrosoft.com; dkim=pass header.d=165gc.onmicrosoft.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=165gc.onmicrosoft.com;
 s=selector1-165gc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtkJQh5CGL1bxKP3H0YD7xZJ69/wAVsCneNFhGRBwRA=;
 b=p6q3CMNXNHMmyGDiHHD7bhh+5QPB9srtD4bitqxV7Km+J/w5V3bzoi23YdJ7cKvmIqi8/LS2hiXhPGZeAoeFPLPZ37HaAb9mVEZN0EQC5Ygtw4FM6nXzHdmyEYdWpmUFz5cMe22z0LxDzBy16JLs0l5sExFGODW6DNFvuYyrqNA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=165gc.onmicrosoft.com;
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:17::24) by YQBPR0101MB4796.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Fri, 18 Jun
 2021 23:13:26 +0000
Received: from YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86]) by YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c132:2223:87d:9e86%6]) with mapi id 15.20.4242.022; Fri, 18 Jun 2021
 23:13:26 +0000
Date:   Fri, 18 Jun 2021 19:13:22 -0400
From:   jjedwa165 <jonathan.edwards@165gc.onmicrosoft.com>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, jonathan.edwards@165gc.onmicrosoft.com
Subject: [PATCH bpf-next] libbpf: add extra BPF_PROG_TYPE check to
 bpf_object__probe_loading
Message-ID: <20210618231322.GA27742@165gc.onmicrosoft.com>
References: <CAEf4BzYtuJKaOSk6nqkMbb4vwmTAXjSWOZUJ8FnRUf_7LKkO1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYtuJKaOSk6nqkMbb4vwmTAXjSWOZUJ8FnRUf_7LKkO1w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.91.65.25]
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:17::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 165gc.onmicrosoft.com (174.91.65.25) by YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 23:13:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2c1de3-e7c0-467f-1e3a-08d932aeacb4
X-MS-TrafficTypeDiagnostic: YQBPR0101MB4796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <YQBPR0101MB4796FF226D972BEB69964D6C9D0D9@YQBPR0101MB4796.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orlOoNH7nBNRndY6SDpjSPLcZzGHoH6VLXfBbNZ+IetNTjmrSZFU6yXFO7qfRUhdOyqnbJKfeW+Yn0OwhbYmhHAZp8/eROTjRtW0ZpJJLqvYON+WRciw74ECr0+MILbIPeTtOiLPB+LuuyFuNKCImFRvFPEg2s5fyb1T7q0Ov1v5kfpvMevRYdhsdDeLicTR6/k27YCLMAnbmycnhYiRRbuk/WolF5oXTr/kDMFi1J3LmZOf/ejza5BH63QM8UZcH9c7eVPBVRLn3h2Ya0YGLeQZfqiN6R/C//moFROvjNSGpMsgLFWnrNT+0nLINot63d4XuhmRxQR3Z8C78zJ/GAS1P3/8gZ5QDVRNdfYSmc827D9Zv1wYxLlcxhmD3NDiR4KSow3x76TcQxOy9yWriXoRT5tGoQRry4OV9jo20Nxc3rUwLcixVaLuYcIFm6rs1WK0u+OQOSc2q7HnUTvLZT98OptutIHzL7clkzq8hnQjTElvmbSNpBIIxi7ZDaEFZmZB+yfSkElLoI6hKYMTVhobiaDgVzlSGqIrnSW7sv09EOctgvysjqa5g+rgfM7pXmblM8bdHsJfHi7doKoaSInthclAFa+xDZHIWHOXIKXa337LrYUqLkCiUvfbZ2GgSbApzM4sblyiFaotkPkyWb55Gh2jKhuYFOGaMYh672meF2Mwlv+wvtcqWW7xzbh7LF28jvbA/qYtiaoM716RVvp3dz5Sx1rcMbg1KYYHkcc2jbq3aDXgpe8eGb1DQ5pTvDVTFEIkQOPaCO8tov4SGawb99VfPCN8ab4N5zOOGa79cmdNxGNRINQhFwThINqyNJoGU1AMwdVpv0msNkcyRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39830400003)(2906002)(66476007)(66946007)(1076003)(6916009)(186003)(26005)(6666004)(8676002)(8936002)(966005)(66556008)(83380400001)(478600001)(38100700002)(38350700002)(33656002)(4326008)(5660300002)(55016002)(16526019)(316002)(107886003)(86362001)(956004)(2616005)(7696005)(52116002)(43062005)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytpbzZicDdDM1dBcTlnbXdPUkE1QjBldEhPVkVrN0NHRHQ2ZFM5eWp4ODAx?=
 =?utf-8?B?Rm50SDU4RDkvR2p0TTF5c1V2TS9VVEF5dWVhbk0wWWJoVE1UUTh1UTNuOXQ5?=
 =?utf-8?B?dWZlOHl2VHliRUhnV21WS1lzSW9UYk1PTDhvUFpQZU1pbWRuSllRd0R6OFB1?=
 =?utf-8?B?dFEwOVhJeVpyQnJxTWd3KzViQnJVTWtISGo1NzdiNGk5eTgzWHo3VjBFMk9a?=
 =?utf-8?B?RHB6RDRQSG84dklDRlNjanQxTnRteWZjK3R0SXVvQUxMVURjc2ZiQXpveVVt?=
 =?utf-8?B?cXJvUU1PWWQvSWhudUN6SGkxVmU4T0FMZ0lZNVhGc3pCczFXWkoxWTJHWGFm?=
 =?utf-8?B?RGhWQXVuallld0ZoeS9NZFFaTkRWTXhSSWI1RldhLzk0MEgyRFZ0dlFZcFhB?=
 =?utf-8?B?L2lHanZnRHJGaFR1ajFQT1A0UE5xeFpScEhNNTRJYm42REdNcDdTQ2dUK0NO?=
 =?utf-8?B?R3p0R2N1YWJWSE5mNHJ1amYrL0lwc2RmTFUvTkg4SnJFUTd1NnlDSjFRN3NI?=
 =?utf-8?B?cy83UkVIRm1GRjd2dEl1eXg1M3RIN000ck5uSTY0WUtDcGJ5QVdUck9ndjhv?=
 =?utf-8?B?bVVDaHlBM3I1NHJYNDV3QUtwWlVSVXlKVmx5a1AxTWtUTndaZlN5ZGJ6MXps?=
 =?utf-8?B?cGxpM01vN1lYWUoxVVF1Vnk0dHM1WGF5bjRiSlN4aFhWSkd4ZFJsUDJxNHRR?=
 =?utf-8?B?SXZkNzZiTHMrT0FhQjA4Y2hJVENlejVFeWdxWmpSVk9jVTJsb3NCYzZMNXUz?=
 =?utf-8?B?cWpWT2NRc2dnb2FnOGI4OGdpL1dpelI5cGcwajNLN0RlZUlBdkVlajhVaWtt?=
 =?utf-8?B?WXpZNHArQklhUTN0akNWenBkK1hQVmVwN3dJWndiVTREUGREMEZBZkwwcW4r?=
 =?utf-8?B?QjZGZ29uOGhxSmNyakhweG5GWGs5bDh5ajFpR1NXSlpMU2tub0JpNnRkMnRO?=
 =?utf-8?B?MFZkVUM4cXI1aFAzSVEzczk0Y2dUdHN1VW51d0NoVHZFNlRieTVsaGRIbDFF?=
 =?utf-8?B?Um1yTkV2bFVlMldaU2IvS01DNFRaSytUZHZGZGI1MkMzWmVJYmtUaW44bGF6?=
 =?utf-8?B?TG0yUldNNFk0ZGZKREdzbTVnU0tvRUdXcndnMzdma3QvZ1VaeWhhQTBzRjdD?=
 =?utf-8?B?Vk01SG1QUWZ4QXhYaEJwNEc5dkNJWU5MWWQ3VXJPZEVwRXMySWs5ZDR0QU05?=
 =?utf-8?B?YlR5bndqdTVJckxtQzFyR2JNQ0tjbWI1MWQ0dU5xWWpmSVErcmRwQ0xGd3BN?=
 =?utf-8?B?M0g5M2d2QlpRODFYclBHRC9UaHdweVF4LzN2YlNyY0R5SjBleXQyOEpBeGFN?=
 =?utf-8?B?K1lteGJKaWw4cHZoekN3MXgxeUNkWDkxd1pHemFKR0dhQVl1Qmc0dTV4bzF0?=
 =?utf-8?B?NEdGSVI1NjU4UFllQ0JlUW5uU043NmhzVlZrLzVyQnF4KzQ3V3phRzlNNXhY?=
 =?utf-8?B?a0JCRExXQzgvUkFFQ2YycmlwNW9qRjdNSkFSUGJ1TEZnQlRMbFVCTWhoN3hR?=
 =?utf-8?B?WlVhNkh2VTZubTRsUDUyM1RNWno0ejNqdGIwR3BkWGNHVVRHbVpoVkl3RzQx?=
 =?utf-8?B?cDNhd0huc2o0V0dFK3RPYm5wV0RYc3d6WTdIRFNxYUtLZVlhWUtxdG9VWmYr?=
 =?utf-8?B?bWcrU3lWMXFXVFMzcXFISm9CUkFQejVRTjBqeWREeC9pdVVBbDdQUlFsQkxD?=
 =?utf-8?B?Skl1ajc0SUVmUkJVVEt4WDRjQktiUEZvMlBGVTB0R3JmMlRNNHRnUkJ6NFFJ?=
 =?utf-8?Q?cZmngOTQe+LQV6FUP9eaYwnOSdS41V8Z2TEHeB2?=
X-OriginatorOrg: 165gc.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c1de3-e7c0-467f-1e3a-08d932aeacb4
X-MS-Exchange-CrossTenant-AuthSource: YQXPR0101MB0759.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 23:13:25.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fa9b7bc4-84f2-4ea2-932a-26ca2f5fb014
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhAXUuh9yx+03NqvDfJyfgZx6cLci8jWJ8XzmwACg+KZKdPc3KdAel0tiEoenezr7o0Pqa8NZnkN8v9gmBgMV6H/usq4l6RWE5kk3G5iRT/amWdkcbP/ao5W/GiPTHP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB4796
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF has been backported for RHEL 7 w/ kernel 3.10-940+ [0]. However 
only the following program types are supported [1]

BPF_PROG_TYPE_KPROBE
BPF_PROG_TYPE_TRACEPOINT
BPF_PROG_TYPE_PERF_EVENT

For libbpf this causes an EINVAL return during the bpf_object__probe_loading
call which only checks to see if programs of type BPF_PROG_TYPE_SOCKET_FILTER
can load.

The following will try BPF_PROG_TYPE_TRACEPOINT as a fallback attempt before 
erroring out. BPF_PROG_TYPE_KPROBE was not a good candidate because on some
kernels it requires knowledge of the LINUX_VERSION_CODE.

[0] https://www.redhat.com/en/blog/introduction-ebpf-red-hat-enterprise-linux-7
[1] https://access.redhat.com/articles/3550581

Signed-off-by: jjedwa165 <jonathan.edwards@165gc.onmicrosoft.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 48c0ade05..1e04ce724 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4000,6 +4000,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	attr.license = "GPL";
 
 	ret = bpf_load_program_xattr(&attr, NULL, 0);
+	if (ret < 0) {
+		attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
+		ret = bpf_load_program_xattr(&attr, NULL, 0);
+	}
 	if (ret < 0) {
 		ret = errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-- 
2.17.1

