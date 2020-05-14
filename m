Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416E1D3889
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 19:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgENRm6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 13:42:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58932 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbgENRm5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 13:42:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EHgad3021800;
        Thu, 14 May 2020 10:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=itYwJ13t3CR/j+uiS6gnKUpc8GpF6VHzLSOoNmSEtQ4=;
 b=Nlwsnk+LRYQKHmPhcUK1yaUcHUyXivofxn1Dqvm8zO/9CERhnnssnIbOU2S/I0uJj9Yk
 VElLlq/LvzFi0mGgl7MSXem+nbNetpLYdbqA8vjlXQNrH6yXnCnWwyV+QT8NXJw71ch1
 em4KpEWpA1Wb4p4ewKtUgEYAWC7sV+URR4s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 310kwsy6ku-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 10:42:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 10:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N603bb40RWsZ77kAFqia66mwIfoTT2ExYV6+bTR2/8858ua57b3fO9wHL0Ox+6QiCDfZfPt1InEk6Eb+E9iX2VKYkaop6uK9bg4KL4tQFJRsufYo6+EF2i6eZ0ELaV1HarUmax9yorY3k8YPmNWh/0H1gFh/PZTmrUmspjhXo92iqoewMdU5RFqBzmXMGAwc6qLVK3tDGZzPpCI6ufztFqiVQa5ODTSSLD/34Hh158bKInhhIhjK7aphDOlY0mfiFzMCD37JeckGzSvW5Lmr3Uh2Wisj5X3A7ulfUvQbkL9fsH2sVgMBeuAlHkCiOaBG/IXDVDCBRw1a4FmdBLZAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itYwJ13t3CR/j+uiS6gnKUpc8GpF6VHzLSOoNmSEtQ4=;
 b=bMebceD9liEafR997H5qbeW+rHKF0P5hcN+iSGOAZijhz50t5dr8HFPBvwsbGU04Z21XAhMxDQvWsN6sbuM+6gujxTcmyZb2S2xicSB3Z48Q6fufWJICSH823uGPR/gkd06SuIT8zI3igUjOo2OiTWXgPOWDwRcMoucSEEJq8qkkHLuUA2qsnIozGsqHVgj8j5yaeHw4xaRSrA1TlyXJDRrl7wg3i69bepqYld9yaaXkYJFtbiciyuwwWhIR3HYxuEws3gBp6mQb3D26tNyKCifGPQZAFk3RQ1RISQlguEAcOv8BTCZSHD1Vba5MQqTSpGGzgfOC35te+dzwWkKtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itYwJ13t3CR/j+uiS6gnKUpc8GpF6VHzLSOoNmSEtQ4=;
 b=VYpsE01gEZlsOQba2E/rrlt3Kyew9OLCSJQoQk5nxxBYD/YbhBQ5/wd1905OJsz8DdLV/9awWEwB1iytNAfFWQcQGcHZcAmsnlqeGL+6aDeITmg2q3TIDYipMRCERTJVw4aazGs1lBaVdh8ZJiOATbuz+fwAnKx7NHXbZ6EhUgg=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Thu, 14 May
 2020 17:42:39 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 17:42:39 +0000
Date:   Thu, 14 May 2020 10:42:38 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/5] selftests/bpf: Add connect_fd_to_fd,
 connect_wait net helpers
Message-ID: <20200514174238.GB22366@rdna-mbp>
References: <cover.1589405669.git.rdna@fb.com>
 <bf2359639287db9adef2c4ddc1a5e16e466a594a.1589405669.git.rdna@fb.com>
 <3f5d4625-32ee-7739-ccfb-53c19e38778b@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f5d4625-32ee-7739-ccfb-53c19e38778b@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:2555) by BYAPR07CA0106.namprd07.prod.outlook.com (2603:10b6:a03:12b::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Thu, 14 May 2020 17:42:38 +0000
X-Originating-IP: [2620:10d:c090:400::5:2555]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd74043-4735-4fae-010c-08d7f82e320f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB341327288E5D0ACBC73D0139A8BC0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OioeJRWgVtJ7leo8yurwMeeWsZlFCj66dy45bTNhE5H+lyeTfREMmkaIKfbvaqwoMFKjFESngRUpGGax/W3LhKMmRJsGbdlQo3uWRWz3yB+XrI1vWooZmINg0dIdaedhQ8Bk/kltt7MhjoE0hMtutsr1ZJ1iNDlrWazOAwpcMzJp499qKS6G2Q2agMYWmjjnyJDkC+eBu7DowtGB7Gi1sYCF32XbonvnbRWwJQXQQIIxJRbVMH8U2L5hlY2Ze3tUWIXB0TDiMd87dpLOspDCFxJZujmdmO+Dm4T8u7Y2kyRINVvlcNjbpdIb96t6bV1ZIA03fksxj49elh/urqXh8M7eLL9KXdwtfP8RlJjai6EmwbQ6xxQXi8JUu+QebnQzEmT/MRyUi1h9+1KeXvw71vnwZmoEYv9RRWuo+0OWQiPVIVIlgQ1xdhOklhhB5ZO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(346002)(396003)(376002)(39860400002)(366004)(136003)(6636002)(86362001)(8676002)(2906002)(33716001)(33656002)(66946007)(316002)(186003)(16526019)(9686003)(1076003)(6496006)(6862004)(5660300002)(6486002)(478600001)(66476007)(52116002)(66556008)(53546011)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: bfPdShS8yoOZdPDnbEaV+9uu+Mq2+1MMLLO9848Y0uJpa093Yxw9DkZ+8J8PP+RAu9hHo0gsmFU8TFnj2WmC44IcRpEx1XlB7N01k5dEvX1xOar67X5NKdsQHcRYRDPpSZYLOEWI/rc2uXstcx4ps045IMU+b2TDT8rAPfZzqYS5mB0G3LdKuoAG3qSd8Q7MWaSnFGl2CIernxqjQHhThfyGqrB8XX3hPa4Mf+ijTCAtlk1Ln303Ah3+L75bzRZtb3s4iCt1ZKsCZTC9RwDVk0Yac8hXpWGEcH9MG0ZjyQfEAsspHsgVzX4l+Lj+zFpMlW2Tnd+iFNExaY/VhXRoeBo0gpqmeX2ZAlA9fhtwVV5gYxQN28SHqbaxTPje6Gtg43de9iHkRUGmAULDKvoU4teqRFuUJqTZorO7a/nJ+vfrJPDy6KKf42k6YBY3ytcD+irGaMvc6Vd627dfmzdCh++4NezZ6kdKgx33frRbEXWDAjKMeZqeb7Wv6JcMvBov4yjwK8KIuNj4uOjA8tVFSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd74043-4735-4fae-010c-08d7f82e320f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 17:42:39.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hkp/YSg8+6cforMrdJom8OvK6OC5D4J2gqiFeVgU7cNe1CaXwf3YN7QNMgMDaDdx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 cotscore=-2147483648
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 08:56 -0700]:
> On 5/13/20 2:38 PM, Andrey Ignatov wrote:

> > @@ -77,8 +81,6 @@ static const size_t timeo_optlen = sizeof(timeo_sec);
> >   int connect_to_fd(int family, int type, int server_fd)
> >   {
> > -	struct sockaddr_storage addr;
> > -	socklen_t len = sizeof(addr);
> >   	int fd;
> >   	fd = socket(family, type, 0);
> > @@ -87,24 +89,64 @@ int connect_to_fd(int family, int type, int server_fd)
> >   		return -1;
> >   	}
> > -	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec, timeo_optlen)) {
> > +	if (connect_fd_to_fd(fd, server_fd) < 0 && errno != EINPROGRESS) {
> > +		close(fd);
> 
> Remote possibility. close(fd) may change error code?

It can in some cases that are rather theoritical in this case (e.g.
buggy multi-threaded program closes fd from another thread right before
this close()).

But I can save/restore it before/after close just in case.

> In my opinion, maybe convert the original syscall failure errno to return
> value and carrying on might be a simpler choice?

I wanted to preserve semantics of connect(2) here: return -1 on error,
or fd >= 0 on success.

I guess if I save/restore errno it should be fine.

> > +		return -1;
> > +	}
> > +
> > +	return fd;
> > +}
> > +
> > +int connect_fd_to_fd(int client_fd, int server_fd)
> > +{
> > +	struct sockaddr_storage addr;
> > +	socklen_t len = sizeof(addr);
> > +
> > +	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVTIMEO, &timeo_sec,
> > +		       timeo_optlen)) {
> >   		log_err("Failed to set SO_RCVTIMEO");
> > -		goto out;
> > +		return -1;
> >   	}
> >   	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
> >   		log_err("Failed to get server addr");
> > -		goto out;
> > +		return -1;
> >   	}
> > -	if (connect(fd, (const struct sockaddr *)&addr, len) < 0) {
> > -		log_err("Fail to connect to server with family %d", family);
> > -		goto out;
> > +	if (connect(client_fd, (const struct sockaddr *)&addr, len) < 0) {
> > +		if (errno != EINPROGRESS)
> > +			log_err("Failed to connect to server");
> 
> Not saying it is possible, but any remote possibility log_err()
> may change error code to EINPROGRESS?

To my best knowledge, neither fprintf(3) nor strerror(3) use
EINPROGRESS, but since in this case having a reliable way to communicate
EINPROGRESS from connect is rather required, I'll save/restore errno for
caling log_err.

-- 
Andrey Ignatov
